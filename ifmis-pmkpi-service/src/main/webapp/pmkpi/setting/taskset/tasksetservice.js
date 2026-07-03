if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.tasksetservice)
    Ext.lt.pmkpi.tasksetservice = {};

Ext.lt.pmkpi.tasksetservice = function(config, service){
    var cmp = {};
    var _treeid,_isleaf,
        _bustype,//业务类型
        _scrWidth =document.body.clientWidth-300,
        _scrHeight =document.body.clientHeight-300;

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
            _bustype = treeNode.superguid;
        } else {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        cmp.query();
    });

    $(function (){
        cmp.query();
    })

    Ext.lt.pmkpi.query = function (){
        cmp.query();
    }

    cmp.query = function (){
        if (!_treeid) {
            _treeid = "treeroot";
        }
        var params = {};
        params.treeid = _treeid;
        params.bustype = _bustype;
        params.isleaf = _isleaf;
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "getData", params, function(datas){
            datatable.setDatas(datas);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.add = function (){
        if (!_treeid || 1 != _isleaf) {
            Ext.lt.ui.alert("请选择左侧末级节点进行新增！",function(){});
            return;
        }
        var url = "/pmkpi/setting/taskset/edit.page";
        var params = {};
        params.treeid = _treeid;
        params.bustype = _bustype;
        params.pagetype = "add";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"绩效任务编辑");
    }

    cmp.mod = function (){
        var selectDatas = datatable.getSelected();
        if (!selectDatas || selectDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条指标进行修改！",function(){});
            return;
        }
        var url = "/pmkpi/setting/taskset/edit.page";
        var params = {};
        params.treeid = _treeid;
        params.bustype = _bustype;
        params.pagetype = "mod";
        params.guid = selectDatas[0]["guid"];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"绩效任务编辑");
    }

    cmp.del = function (){
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        var params = {};
        params.selDatas = datas;
        var rs = Ext.lt.RCP.asyncall(service , "checkdel", [params]);
        if (rs > 0) {
            Ext.lt.ui.alert('选中任务中存在下达数据，不能进行删除！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "del", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！',function(){
                        cmp.query();
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }


    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    return cmp;
}