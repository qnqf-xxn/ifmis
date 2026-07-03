if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfreview){
    Ext.lt.pmkpi.perfreview = {};
}

Ext.lt.pmkpi.perfreview.batchadd = function(config, service){
    var cmp = {};

    var _workflow = config.workflow;
    var _bustype = config.bustype;
    var _displaycols = [];

    $(function (){
        cmp.setTableColum();
        Ext.lt.pmkpi.query();
    })

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.bustype = _bustype;
        params.type = "batchadd";
        params.beanid = "pmkpi.perfreview.PerfReviewBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 批量抓取未提交到绩效的数据
     */
    cmp.batchadd = function (obj){
        Ext.lt.ui.loadingShow();
        var datas = datatable.getRecordSet().toArray();
        if (datas && datas.length > 0) {
            var params = {};
            params.workflow = _workflow;
            params.bustype = _bustype;
            params.datas = datas;
            Ext.lt.RCP.call(service, "batchadd", [params], function(rs) {
                if(rs && rs.success){
                    Ext.lt.ui.alert(obj.name + "成功！",function(){
                        parent.Ext.lt.pmkpi.query();
                        try {
                            Ext.lt.ui.closeModalWindow();
                        } catch (e) {
                            Ext.lt.ui.modalWindow.close();
                        }
                    });
                }
                Ext.lt.ui.loadingClose();
            }, function (){
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert(obj.name + '失败！',function(){
                });
            })
        } else {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('页面无数据！',function(){
            });
        }
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype && config.lefttabtype.indexOf(_bustype) != -1) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        var page = {};//datatable.getPage();
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    return cmp;
}