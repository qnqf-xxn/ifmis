if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.evaluatetemp)
    Ext.lt.pmkpi.evaluatetemp = {};
var scrWidth=document.body.clientWidth;
var scrHeight=document.body.clientHeight;
var windowx;
Ext.lt.pmkpi.evaluatetemp = function(config, service){
    var cmp = {};
    Ext.lt.pmkpi.evaluatetemp.tokenid = Ext.lt.token.getTokenid();
    Ext.lt.pmkpi.evaluatetemp.bobeanid = config.bobeanid;
    serviceid = config.serverid;

    cmp.draw = function() {
        cmp.query();
    }
    $(function () {
        cmp.query();
    })

    //查询
    cmp.query = function (){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getData", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.toAdd = function(){
        var params = {};
        var url = '/pmkpi/evaluatetemp/add.page';
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.mainguid = newguid;
        params.viewtype = 'add';
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"新增评价类型");
    }

    cmp.toEdit = function (){
        var params = {};
        var data = datatable.getSelected();
        params.viewtype = 'update';
        if(data.size()==1){
            var guid=data[0].guid;
            params.mainguid=guid;
            var url = '/pmkpi/evaluatetemp/add.page';
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"修改评价类型");
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能修改一条数据！');
        } else {
            Ext.lt.ui.alert('请选择要修改的数据！');
        }
    }

    cmp.del = function (){
        var size = datatable.getRecordSet().size();
        if(size>0){
            var selecteds = datatable.getSelected().size();
            if (selecteds <= 0) {
                Ext.lt.ui.alert('请选择要删除的数据！');
                return;
            }
            Ext.lt.ui.confirm('是否删除已选择评价类型信息？',null,function(is){
                if(is){
                    var data = datatable.getSelected();
                    var config = {};
                    if (data.size() <= 0) {
                        Ext.lt.ui.alert('请选择要删除的数据！',function(){
                        });
                        return;
                    }
                    config.deldatas = data;
                    config = Ext.lt.RCP.asyncall(serviceid , "deldatas", config);
                    if(config.error){
                        Ext.lt.ui.alert(config.error);
                    }
                    cmp.query();
                }
            });
        }else{
            Ext.lt.ui.alert('页面无数据！');
            return ;
        }
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    return cmp;
}



$(window).resize(function () {          //当浏览器大小变化时
    var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
    if(windowx){windowx.resize(scrWidth, scrHeight);}
});

