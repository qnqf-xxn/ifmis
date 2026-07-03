if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};

Ext.lt.pmkpi.sumindex = function (config, serviceid) {
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _viewtype = "query";
    var _pro_code = config.pro_code;
    var _cmp = {};
    var isFirst = true;
    var scrWidth = document.body.clientWidth;

    //页面加载完成后执行
    $(function () {
        perfcommon.initDatatable();
        _cmp.setTableColum();
        _cmp.query();
        isFirst = false;
    });

    /**
     * 页面初始化.
     */
    _cmp.query = function () {
        var params = {};
        params.pro_code = _pro_code;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", [params], function (rs) {
            datatable.setDatas(rs.datas);
            Ext.lt.ui.loadingClose();
        })
    }

    /**
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        var upcols = [];
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            // if (col["colcode"] == "indexval") {
            //     upcols.push(col["colcode"]);
            //     col.fn = function (l, c, data, col) {
            //         if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || ismergeindex != "1") {
            //             var indexvalue = !data.indexval ? "" : data.indexval;
            //             return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
            //         } else {
            //             var computesignstr = "";
            //             for (var i = 0; i < _signs.size(); i++) {
            //                 if (data.computesign == _signs[i].guid) {
            //                     computesignstr = _signs[i].name;
            //                 }
            //             }
            //             var unit = "";
            //             if (data["meterunit"]) {
            //                 unit = data.meterunit;
            //             }
            //             var returnstr = !data.indexval ? computesignstr + unit : computesignstr + data.indexval + unit;
            //             return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
            //         }
            //     }
            // }
            if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    _cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "name") {
                col.display = true;
                col.colwidth = scrWidth/4;
                col.initwidth = scrWidth/4;
                col.minwidth = scrWidth/4;
                col.width = scrWidth/4;
            } else if (col.colcode == "obligate1" || col.colcode == "isapply") {
                col.display = false;
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    return _cmp;
}
