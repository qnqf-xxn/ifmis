if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.busauditdefine)
    Ext.lt.pmkpi.busauditdefine = {};

Ext.lt.pmkpi.busauditdefineservice = function(config, service){
    var cmp = {};
    var menuQTree;
    var wfstatusQTree;
    var iswf = false;

    $(function () {
        cmp.drawMenuTree();
        cmp.drawWfStatusTree();
    })

    //显示单位树
    cmp.drawMenuTree = function() {
        cmp.createMenuTree(config.menudata);
    };

    //显示工作流树
    cmp.drawWfStatusTree = function() {
        cmp.createWfStatusTree(config.wfstatusdata);
    };

    cmp.addmenu = function(){
        var meundatas = menuQTree.getSelected();
        if(!meundatas || meundatas.length == 0){
            Ext.lt.ui.alert("请左侧菜单树选择新增下级菜单！",null,function () {});
            return;
        }
        var meundata = meundatas[0];
        if(!meundata || !meundata.url || meundata.url == "" || meundata.url == "#"){
            Ext.lt.ui.alert("选择的菜单不支持新增下级菜单！",null,function () {});
            return;
        }
        var url = "/pmkpi/busauditdefine/editmenu.page";
        var params = {};
        params.pagetype = "add";
        params.menuid = meundata.guid;
        params.levelno = meundata.levelno;
        // params.key = meundata.url.split(".page")[0];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,800,500,"审核定义扩展菜单编辑");
    }

    cmp.modmenu = function(){
        var meundatas = menuQTree.getSelected();
        if(meundatas.length == 0){
            Ext.lt.ui.alert("请选择要修改的菜单！",null,function () {});
            return;
        }
        var meundata = meundatas[0];
        if (meundata.isleaf != 1 || meundata.url){
            Ext.lt.ui.alert("选择的菜单不允许修改！",null,function () {});
            return;
        }
        var url = "/pmkpi/busauditdefine/editmenu.page";
        var params = {};
        params.menuid = meundata.guid;
        params.levelno = meundata.levelno;
        params.pagetype = "mod";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,800,500,"审核定义扩展菜单编辑");
    }

    Ext.lt.pmkpi.menutree = function(){
        Ext.lt.RCP.call(service, "getMenuTree", null,
            function(data){
                if(data){
                    cmp.createMenuTree(data);
                }
                Ext.lt.ui.loadingClose();
            }, function () {
                alert('查询左侧树失败!');
                Ext.lt.ui.loadingClose();
            });
    }

    cmp.delmenu = function(){
        var meundatas = menuQTree.getSelected();
        if(meundatas.length == 0){
            Ext.lt.ui.alert("请选择要删除的菜单！",null,function () {});
            return;
        }
        var meundata = meundatas[0];
        if (meundata.isleaf != 1 || meundata.url){
            Ext.lt.ui.alert("选择的菜单不允许删除！",null,function () {});
            return;
        }
        Ext.lt.ui.confirm('是否确认删除？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.menuid = meundata.guid;
                Ext.lt.RCP.call(service , "delMenu", params,function(rs){
                    if(rs.error){
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert(rs.error);
                    } else{
                        Ext.lt.ui.alert(("菜单删除成功！"),{},function(ret) {
                            Ext.lt.pmkpi.menutree();
                            Ext.lt.ui.loadingClose();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var meundata = menuQTree.getSelected();
        if(meundata.length == 0){
            Ext.lt.ui.alert(("请选择菜单！"),{},function(ret){});
            return;
        }
        var busguid = '';
        var wfstatsudata = wfstatusQTree.getSelected();
        if (wfstatsudata.length != 0) {
            busguid = meundata[0].guid + "_" + wfstatsudata[0].guid
        } else {
            busguid = meundata[0].guid
        }
        var newguid = Ext.lt.RCP.asyncall(service , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.busguid = busguid;
        newdata.rowtype = "add";
        newdata.errtype = "force";
        Ext.lt.pmkpi.isadd = true;
        datatable.getRecordSet().addData(newdata,999);
    });

    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert(("请选择要删除的数据！"),{},function(ret){});
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                datatable.removeData(selDatas);
            }
        })
    });

    cmp.save = function(){
        if (!datatable.checkAll()) return false;//先校验
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        Ext.lt.ui.loadingShow();
        if (params.datas.length != 0 || params.updatas.length != 0 || params.deldatas.length != 0){
            Ext.lt.RCP.call(service, "save", params,
                function(resp){
                    if(resp && resp.success){
                        Ext.lt.ui.alert("保存成功！",null,function () {});
                        Ext.lt.pmkpi.query(iswf);
                    } else {
                        Ext.lt.ui.alert("保存失败！",null,function () {});
                    }
                    Ext.lt.ui.loadingClose();
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert("保存失败！",null,function () {});
                });
        }else{
            Ext.lt.ui.alert("请选择数据",null,function () {});
        }
    }

    //创建菜单
    cmp.createMenuTree = function(data){
        var num = 1;
        if (data.length < 20) {
            num = 2;
        }
        menuQTree = new Ext.lt.Qtree({
            data : data,
            search:true,
            outformart : '#code-#name',
            doRootSelected: false,
            endlevelselect: false,
            showRootNode: true,
            expandlevel: num,
            field : {
                id : "guid",
                name : "name",
                code : "code",
                sid : "superguid",
                level : "levelno",
                isleaf : "isleaf"
            },
            on:{
                'nodeclick' : function() {
                    iswf = false;
                    wfstatusQTree.clearSelected();
                    wfstatusQTree.reflash();
                    Ext.lt.pmkpi.query(iswf);
                }
            }
        });
        var lefttreediv = document.getElementById('lefttreediv');
        menuQTree.draw(lefttreediv);
    }

    /**
     * 创建工作流状态菜单树
     * @param data
     */
    cmp.createWfStatusTree = function (data) {
        wfstatusQTree = new Ext.lt.Qtree({
            data : data,
            outformart : '#code-#name',
            linkchild:true,
            search:true,
            doRootSelected: false,
            endlevelselect: false,
            showRootNode: true,
            selectmode:'r',
            field : {
                id : "guid",
                name : "name",
                code : "code",
                sid : "superguid",
                level : "levelno",
                isleaf : "isleaf"
            },
            on:{
                'nodeclick' : function() {
                    iswf = true;
                    Ext.lt.pmkpi.query(iswf);
                }
            }
        });
        var contenttreediv = document.getElementById('contenttreediv');
        wfstatusQTree.draw(contenttreediv);
    }

    Ext.lt.pmkpi.query = function (iswf) {
        var meundata = menuQTree.getSelected();
        if(meundata.length == 0){
            alert('请选择菜单!');
            return;
        }
        var busguid = '';
        if (iswf) {
            var wfstatsudata = wfstatusQTree.getSelected();
            if(wfstatsudata.length == 0){
                alert('请选择工作流状态!');
                return;
            }
            if (wfstatsudata.length != 0) {
                busguid = meundata[0].guid + "_" + wfstatsudata[0].guid;
            }
        } else {
            busguid = meundata[0].guid;
        }
        var params = {};
        params.busguid = busguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service, "getDatas", params,
            function(resp){
                if(resp){
                    datatable.setDatas(resp.data);
                }
                Ext.lt.ui.loadingClose();
            }, function () {
                alert('查询失败!');
                Ext.lt.ui.loadingClose();
            });
    }

    return cmp;
}