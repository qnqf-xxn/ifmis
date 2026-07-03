if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptmanage){
    Ext.lt.pmkpi.deptmanage = {};
}


Ext.lt.pmkpi.deptmanageservice = function(config, service){
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _savetable = config.tablecode,
        _agency,
        _tablecode,
        _ctablecode,
        _tabfilter,
        _tabcode,
		_name,
        _pagetype,
        _uikey,
        _defquery,
        _orderby,
        _deltables,
        _delcols,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;

    var serviceid = service;
    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        if(!_agency){
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.ctablecode = _ctablecode;
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            _name=treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });


    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        _deltables = config.deltables;
        _delcols = config.delcols;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        // for(var i=0; i<cols.length; i++){
        //     var col = cols[i];
        //     if(col["colcode"] == "name"){
        //         col.fn = function(l,c,data,col){
        //             return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
        //         }
        //         col.onclick = function(td, el, l, c, d) {
        //             var url = _uikey;
        //             url += '.page?pagetype=editreport'
        //             url += '&tokenid=' + Ext.lt.token.getTokenid();
        //             url += '&mainguid=' + d.guid + "&agency=" + d.agencyguid;
        //             url += '&flg=query&_workflow=' + _workflow;
        //             Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门绩效目标申报");
        //         };
        //     }
        // }
    });

    /**
     * 填报/修改
     */
    cmp.add = function (obj){
        var config = obj.config;
        var data = datatable.getSelected();
        if(data.length <= 0){
            Ext.lt.ui.alert("请选中至少一条数据进行下达！",function(){});
            return;
        }
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        var url = _uikey + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth-300,scrHeight-300,"部门绩效监控");
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.deltables = _deltables;
        params.delcols = _delcols;
        deptcmp.deltable(datatable, params);
    }

    //送审/审核
    cmp.wfAudit = function (obj){
        var actionname = obj.name;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + actionname + "的数据！",function(){});
            return;
        }
        if (!deptcmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        deptcmp.doAction(obj, params);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        var config = obj.config;
        var tabconfig = eval('(' + config + ')');
        _ctablecode = tabconfig.tablecode;
        Ext.lt.pmkpi.query();
    }


    /**
     * 保存
     * @returns {boolean}
     */
    cmp.save = function(){
        if (!editform.check()) return false;
        var datas = parent.datatable.getSelected();
        var params = {};
        params.datas = datas;
        params.infodata = editform.getEditFormValues();
        params.tablecode = _savetable;
        params.workflow = _workflow;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "saveTask", params, function(rs){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达成功！',function(){
                Ext.lt.ui.closeModalWindow();
                window.parent.Ext.lt.pmkpi.query();
            });
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达失败！',function(){
            });
        });
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    return cmp;
}

