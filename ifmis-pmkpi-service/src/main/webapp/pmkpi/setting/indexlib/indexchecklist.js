if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexchecklist)
    Ext.lt.pmkpi.indexchecklist = {};

var zcolumns = {};
Ext.lt.pmkpi.indexchecklist = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _treeid,
        _levelno = 1,
        _indextype = config["indextype"],
        _tabtype =config["tabtype"],
        _menuid = config["menuid"],
        _isleaf,
        _tabfilter, //页签标签
        _tabcode, ////页签编码
        _datatype = config["datatype"],
        _queryfilter,
        _workflow = config["workflow"],
        isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
    var cmp = {};
    window.parent.Ext.lt.pmkpi.childwindow = window;
    /**
     * 加载完成后执行.
     */
    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        Ext.lt.pmkpi.query();
    })
    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        cmp.query();
    }
    /**
     * 查询
     * @filter --条件
     */
    cmp.query = function(filter){
        if (!_treeid) {
            _treeid = "treeroot";
        }
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tabtype = _tabtype;
        params.isleaf = _isleaf;
        params.menuid = _menuid; //菜单
        params.tabcode = _tabcode; // 页签编码
        params.tabfilter = _tabfilter; //页签过滤条件
        params.workflow = _workflow; //工作流
        params.levelno = _levelno;
        if (filter) {
            params.querySql = filter; //工作流
        }
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.setting.indexlib.report.IndexCheckBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    /**
     * 确认
     * @returns {boolean}
     */
    cmp.save = function(){
        var datas = datatable.getSelected();
        if (!datas || datas.length <= 0) {
            Ext.lt.ui.alert('请选择指标！',function(){
            });
            return;
        }
        if (!datatable.check()) {
            return false;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = datas;
        params.workflow = _workflow;
        params.indextype = _indextype;
        params.tabtype = _tabtype;
        Ext.lt.RCP.call(service , "saveDatas", params, function(rs) {
            Ext.lt.ui.alert('确认成功！',function(){
                Ext.lt.ui.closeModalWindow();
                window.parent.Ext.lt.pmkpi.query();
            });
            Ext.lt.ui.loadingClose();
        }, function(rt) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('确认失败：' + rt,function(){
            });
        });
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "upstatus") {
                col.oneditstart = function (table, el, l, c, d) {
                    Ext.lt.pmkpi.doMapper(_datatype,table.getCol(c));
                    this.config.isMulti = false;
                    return;
                }
            }
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        if (obj.queryform){
            _queryfilter = obj.queryform.getQuerySQL();
        }
        cmp.query(_queryfilter);
    });

    return cmp;
}