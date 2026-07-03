if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.busmenuedit)
    Ext.lt.pmkpi.busmenuedit = {};

Ext.lt.pmkpi.busmenueditservice = function(config, service){
    var levelno = config.levelno;//父级菜单级次
    var menuid = config.superid;//父级菜单guid
    var pagetype = config.pagetype;
    var cmp = {};

    $(function () {
        if (pagetype == "mod") {
            if (config.infodata) {
                editform.setdisabled({guid:true});//设置基本信息不可编辑
                editform.synchEditformByObj(config.infodata.data[0]);
            }
        } else {
            editform.setdisabled({guid:false});//设置基本信息不可编辑
        }
    })

    //新增/修改
    cmp.save = function(){
        if (!editform.check()) return;//先校验
        var params = {};
        var infodata = editform.getEditFormValues();
        if (pagetype == "add") {  //新增
            infodata.levelno = parseInt(levelno) + 1;
            infodata.superid = menuid;
        }else if(pagetype == "mod"){ //修改
            infodata.levelno = parseInt(levelno);
        }
        infodata.isleaf = 1;
        params.infodata = infodata;
        Ext.lt.RCP.call(service , "infosave", params, function(rs){
            if(rs.error){
                Ext.lt.ui.alert(rs.error);
            } else{
                Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                    window.parent.Ext.lt.pmkpi.menutree();
                    Ext.lt.ui.closeModalWindow();
                });
            }
        });
    }
    return cmp;
}