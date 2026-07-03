if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.question)
	Ext.lt.pmkpi.question = {};

Ext.lt.pmkpi.question = function(config, service){
    var cmp = {};
    var serviceid = service,
    	_tablecode,
    	_wfid,
        _nodeguid;	

    /**
     * 
     */
    Ext.lt.message.hook("left", "click",function(obj){
    	debugger;
        var treeNode = obj.node.data;
        if(treeNode && treeNode.levelno == '2'){
        	_nodeguid = treeNode.guid;
        	_wfid = treeNode.superguid;
            cmp.query();
        }
    });
    
    Ext.lt.message.hook("busdatatable", "drawed",function(resp){
    	_tablecode = resp.uiconfig.tablecode;
    	/*var table_eva={
                nodeguid:{
                    asyncloaddata:function(param){
                    	debugger;
                        param.data=_framedata;
                    },
                    change: function(param){
                    	debugger
                        //_findex = param.sels[0].guid;
                    }
                }
            }
    	resp.datatablepanel.attachEvent(table_eva);*/
    });
    /**
     * 新增表格行
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.rowtype = "add";
        datatable.getRecordSet().addData(newdata,1);
    });
    
    /**
     * 删除表格行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                datatable.removeData(selDatas);
            }
        })
    });
    
    /**
     * 基础信息保存
     */
    cmp.tablesave = function (obj){
        if (!datatable.checkAll()) return;//先校验
        var params= {};
        params.tablecode = _tablecode;
        params.datas = datatable.getRecordSet().toArray();
        params.nodeguid = _nodeguid;
        params.wfid = _wfid;
        Ext.lt.RCP.call(serviceid , "save", params, function(rs){
            if (rs && rs.success) {
                Ext.lt.ui.alert('保存成功！',function(){
                    cmp.query();
                });
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！',function(){
            });
        });
    }

    /**
     * 查询
     */
    cmp.query = function(){
        var params = {};
        params.wfid = _nodeguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    return cmp;
}

