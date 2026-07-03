if(!Ext.lt){
    Ext.lt = {};
}
if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
Ext.lt.pmkpi.hbdeptindex = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _viewtype = config.viewtype,
        _busguid = config.busguid,
        _saveAgency = config.saveAgency,
        _yearflag = config.yearflag,
        _signs = config.signs,
        _viewtype = config.viewtype,
        _mainguid = config.mainguid,
        _indexstandards = config.indexstandards,
        _perfendvaltype = config.perfendvaltype,
        _signs = config.signs

    ;
    var _cmp = {};
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;

    var _displaycols = [];
    var iszc;


    $(function () {
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        } else {
            if (_yearflag == "1") {
                common.changTooltoolbuttontCode('copyindex');
            }
        }
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        _cmp.setTableColum();
        _cmp.query();
    })

    _cmp.query = function(){
        var params = {};
        params.mainguid = _mainguid;
        params.yearflag = _yearflag;
        params.viewtype = _viewtype;
        params.compconfigid = _yearflag + "datalist";
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "getDatas", params, function(rs){
            iszc = rs.hidButtons;
            setMidSaveHidButtons(rs);
            datatable.setDatas(rs.data);
            parent._isQuery = true;
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    _cmp.save = function(){
        if (!_cmp.check()) return false;//先校验
        var params = {};
        var tabledatas = datatable.getRecordSet().toArray();
        if (tabledatas && tabledatas.length > 0) {
            for (var a = 0, leni = tabledatas.length; a < leni; a++) {
                if(tabledatas[a].levelno == "3"){
                    if (!common.checkSpaceValue(tabledatas[a],"绩效指标-第" + (tabledatas[a]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                    tabledatas[a].name = convertStr(tabledatas[a].name);
                    tabledatas[a].indexval = convertStr(tabledatas[a].indexval);
                    tabledatas[a].kpi_val = convertStr(tabledatas[a].kpi_val);
                }
            }
        }
        params.datas = tabledatas;
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.mainguid = _mainguid;
        params.yearflag = _yearflag;
        params.compconfigid = _yearflag + "datalist";
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            _cmp.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    _cmp.savetmp = function (obj){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        var params = {};
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            var rs = {};
            rs.success = true;
            Ext.lt.ui.loadingClose();
            return rs;
        }
        params.data = datas;
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = _yearflag + "datalist";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service, "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            _cmp.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    _cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = _yearflag + "datalist";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service, "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            _cmp.query();
        }
        return rs;
    }

    /**
     * 复制长期绩效指标
     */
    _cmp.copyindex = function () {
        Ext.lt.ui.confirm("是否确认复制？", {icon: "warn"}, function (ret) {
            if (ret) {
                var params = {};
                params.mainguid = _mainguid;
                params.yearflag = '1';
                params.url = datatable.config.pageurl;
                params.componentid = datatable.config.server;
                params.compconfigid = "1datalist";
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service, "getIndexs", params, function (datas) {
                    if (datas.length > 0) {
                        var indexs = datatable.getRecordSet().toArray();
                        for (var j = 0; j < datas.length; j++) {
                            for (var i = 0; i < indexs.length; i++) {
                                if (indexs[i].code == datas[j].code && datas[j].levelno == '2') {
                                    if (indexs[i].rowtype != "add") {
                                        datas[j].rowtype = indexs[i].rowtype;
                                    }
                                    datas[j].guid = indexs[i].guid;
                                    datas[j].kpi_id = indexs[i].kpi_id;
                                    datas[j].createtime = indexs[i].createtime;
                                    datas[j].create_time = indexs[i].create_time;
                                    indexs.remove(indexs[i]);
                                    break;
                                } else if (indexs[i].isfixed == '1' && indexs[i].levelno == '3' && indexs[i].name == datas[j].name) {
                                    if (indexs[i].rowtype != "add") {
                                        datas[j].rowtype = indexs[i].rowtype;
                                    }
                                    datas[j].guid = indexs[i].guid;
                                    datas[j].kpi_id = indexs[i].kpi_id;
                                    datas[j].createtime = indexs[i].createtime;
                                    datas[j].create_time = indexs[i].create_time;
                                    indexs.remove(indexs[i]);
                                    break;
                                }
                            }
                        }
                        Ext.lt.pmkpi.doMapper(_signs, datatable.getCol("computesign"));
                        Ext.lt.pmkpi.doMapper(_perfendvaltype, datatable.getCol("endvaltype"));
                        Ext.lt.pmkpi.doMapper(_indexstandards, datatable.getCol("indexstandards"));
                        datatable.getRecordSet().addData(datas, 999);
                        Ext.lt.ui.alert('复制成功！', function () {
                        });
                    } else {
                        Ext.lt.ui.alert('长期指标未填报，请填报后进行复制操作！', function () {
                        });
                    }
                    Ext.lt.ui.loadingClose();
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('查询失败！', function () {
                    });
                });
            }
        });
    }

    _cmp.check = function () {
        var datas = datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if (datas[i]["levelno"] == 3) {
                if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。", {timeout: 1}, function () {
                    });
                    return;
                }
                for (var j = 0,lenj = cols.length; j < lenj; j++) {
                    if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                        var value = datas[i][cols[j].colcode];
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。", {timeout: 1}, function () {
                            });
                            Ext.lt.ui.loadingClose();
                            return false;
                        }
                        if (cols[j].colcode == 'indexval' && value.match(RegExp("[*_-]")) != null) {
                            Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。", {timeout: 1}, function () {
                            });
                            return false;
                        }
                        if ((cols[j].colcode == 'name') && (value == "-" || value == "_" || value == "*")) {
                            Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。", {timeout: 1}, function () {
                            });
                            Ext.lt.ui.loadingClose();
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "indexval"){
                upcols.push(col["colcode"]);
                col.cseditfn = function (i, j, d, style) {
                    if (d.levelno != "3") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.fn = function (l, c, data, col) {
                    if (data.levelno == "2") {
                        return "<font style=\"margin-left:10px;\"></font>";
                    } else {
                        var indexvalue = !data.indexval ? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                    if (!d.computesign) {
                        Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                        });
                        return false;
                    }
                    el.innerText =  d.indexval != undefined ? d.indexval : '';
                    table.getCol(c).mapping = null;
                    table.nowtype="input";
                    table.getCol(c).format = "";
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6'){
                        if(!checkReferencepole(d.indexval)){
                            d.indexval = '';
                            return false;
                        }
                    }
                }
            }

            if(col["colcode"] == "snindexval"){
                upcols.push(col["colcode"]);
                col.cseditfn = function (i, j, d, style) {
                    if (d.levelno != "3") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.fn = function (l, c, data, col) {
                    if (data.levelno == "2") {
                        return "<font style=\"margin-left:10px;\"></font>";
                    } else {
                        var indexvalue = !data.snindexval ? "" : data.snindexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                    if (!d.computesign) {
                        Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                        });
                        return false;
                    }
                    el.innerText =  d.snindexval != undefined ? d.snindexval : '';
                    table.getCol(c).mapping = null;
                    table.nowtype="input";
                    table.getCol(c).format = "";
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6'){
                        if(!checkReferencepole(d.snindexval)){
                            d.snindexval = '';
                            return false;
                        }
                    }
                }
            }

            if(col["colcode"] == "qnindexval"){
                upcols.push(col["colcode"]);
                col.cseditfn = function (i, j, d, style) {
                    if (d.levelno != "3") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.fn = function (l, c, data, col) {
                    if (data.levelno == "2") {
                        return "<font style=\"margin-left:10px;\"></font>";
                    } else {
                        var indexvalue = !data.qnindexval ? "" : data.qnindexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                    if (!d.computesign) {
                        Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                        });
                        return false;
                    }
                    el.innerText =  d.qnindexval != undefined ? d.qnindexval : '';
                    table.getCol(c).mapping = null;
                    table.nowtype="input";
                    table.getCol(c).format = "";
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6'){
                        if(!checkReferencepole(d.qnindexval)){
                            d.qnindexval = '';
                            return false;
                        }
                    }
                }
            }

            if (col["colcode"] == "computesign") {
                upcols.push(col["colcode"]);
                col.cseditfn = function (i, j, d, style) {
                    if (d.levelno != "3") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.computesign && d.computesign != '6') {
                        if (d.indexval && !checkReferencepole(d.indexval)) {
                            d.indexval = '';
                            d.qnindexval = '';
                            d.snindexval = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if ((d.computesign && d.computesign == "6") || (!d.computesign || d.computesign == "")) {
                        d.indexval = '';
                        d.qnindexval = '';
                        d.snindexval = '';
                        d.meterunit = '';
                        return false;
                    }
                }
            }

            //一二级指标不可修改
            if(col["colcode"]=="name"){
                upcols.push(col["colcode"]);
                col.cseditfn = function (i, j, d, style) {
                    if (d.levelno == "2" && d.isfixed != "2") {
                        style = 'style="background-color:#f2f2f2;"';
                    } else if(d.levelno == "3" && d.isfixed == "1"){
                        style = 'style="background-color:#f2f2f2;"';
                    } else if (d.levelno == "1") {
                        style = 'style="background-color:#f2f2f2;"';
                    }
                    return style;
                }
                col.oneditstart = function(table,el,l,c,d){
                    if (d.levelno == "2" && d.isfixed != "2") {
                        return false;
                    } else if(d.levelno == "3" && d.isfixed == "1"){
                        return false;
                    } else if (d.levelno == "1") {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.levelno == "2" && d.isfixed == "2") {
                        d.lv2_perf_ind_name = d.name;
                        var datas = datatable.getRecordset().query({superid: d['guid']});
                        for (var i=0; i<datas.length; i++) {
                            datas[i].lv2_perf_ind_name = d.name;
                        }
                    }
                }
            }

            if(col["colcode"]=="obligate1"){
                upcols.push(col["colcode"]);
                if (_viewtype != "query"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if (data.levelno == "1" && data.guid == '6') {
                            html = '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:hbdeptindex.indexadd("'+data.guid+'","'+data.findex+'")\'>新增</a>';
                        } else if(data.levelno == "2" && data.findex == '6'){
                            html = '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:hbdeptindex.indexadd("'+data.guid+'","'+data.findex+'")\'>新增</a>';
                            html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:hbdeptindex.indexdel("","'+data.guid+'")\'>删除</a>';
                        } else if (data.levelno == "2") {
                            html = '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:hbdeptindex.indexadd("'+data.guid+'","'+data.findex+'")\'>新增</a>';
                        } else if(data.levelno == "3" && data.isfixed != "1"){
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:hbdeptindex.indexdel("","'+data.guid+'")\'>删除</a>';
                        }
                        return html;
                    }
                } else {
                    col.isvisiable = 0;
                    col.display = false;
                }
            }

            if (_viewtype == 'query' && !col["alias"] != "序号" && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
        if (_viewtype != 'query') {
            for (var i = 0; i < cols.length; i++) {
                if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                    var iscol = false;
                    for (var j = 0; j < upcols.length; j++) {
                        if (cols[i]["colcode"] == upcols[j]) {
                            iscol = true;
                            break;
                        }
                    }
                    if (!iscol) {
                        cols[i].cseditfn = function (i, j, d, style) {
                            if (d.levelno == "2" || d.levelno == "1") {
                                style = 'style="background-color:#f2f2f2;"';
                            }
                            return style;
                        }
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            if (d.levelno != "3") {
                                return false;
                            }
                        }
                    }
                }
            }
        }
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    _cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号" && config.yearflag) {
                if (config.yearflag == _yearflag) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
            if (col.colcode == "indexval") {
                if (_yearflag == "1") {
                    col.alias = "指标值";
                    col.head = "";
                } else if (_yearflag == "1") {
                    col.alias = config.title;
                    col.head = "['指标值']";
                }
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    _cmp.indexadd = function (sindex,findex) {
        var data = {};
        data.guid = createUUID().replace(/-/g, '');
        data.rowtype = "add";
        data.mainguid = _mainguid;
        if (findex == "6" && sindex == "6") {
            data.findex = findex;
            data.superid = findex;
            data.sindex = data.guid;
            data.code = data.guid;
            data.levelno = 2;
            data.isleaf = 0;
            data._isleaf = 0;
        } else if (findex == "6" && sindex != "6") {
            var datas = datatable.getRecordset().query({guid: sindex});
            if (datas && datas.length > 0) {
                data.lv2_perf_ind_name = datas[0].lv2_perf_ind_name;
            }
            data.findex = findex;
            data.superid = sindex;
            data.sindex = sindex;
            data.code = '619999';
            data.lv2_perf_ind_code = sindex;
            data.lv3_perf_ind_code = '619999';
            data.levelno = 3;
            data.isleaf = 1;
            data._isleaf = 1;
        } else {
            data.findex = findex;
            data.superid = sindex;
            data.sindex = sindex;
            data.levelno = 3;
            data.isleaf = 1;
            data._isleaf = 1;
        }
        data.isfixed = 2;
        datatable.getRecordSet().addData(data,999);
    }

    /**
     * 删除.
     */
    _cmp.indexdel = function (obj, guid) {
        var data = [];
        if (!guid) {
            data = datatable.getSelected();
            if (data.length == 0) {
                Ext.lt.ui.alert("请选择需要删除的指标！", function () {
                });
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid: guid});
        }
        var mesg = "确认要删除选中指标？";
        for(var i=0; i<data.length; i++){
            if(data[i].isfixed == "1"){
                Ext.lt.ui.alert("固化指标无法删除！",function(){});
                return;
            }
            if (data[i].levelno == "2") {
                mesg = "删除二级指标，同步删除下级三级指标，是否确认删除？";
            }
        }
        Ext.lt.ui.confirm(mesg, {icon: "warn"}, function (ret) {
            if (ret) {
                if (data && data.length > 0) {
                    var deldatas = [];
                    for (var i = 0; i < data.length; i++) {
                        if (data[i]["levelno"] == "2") {
                            deldatas.push(...datatable.getRecordset().query({superid: data[i]['code']}));
                        }
                        deldatas.push(data[i]);
                    }
                    datatable.removeData(deldatas);
                }
            }
        })
    }

    /**
     * 导入
     * @param obj
     */
    _cmp.import = function (obj) {
        if (iszc == "暂存") {
            _cmp.imp(obj);
        } else {
            Ext.lt.ui.confirm("导入指标会清除暂存指标，请先点击保存后再进行导入！", {icon: "warn"}, function (ret) {
                if (ret) {
                    _cmp.imp(obj);
                }
            });
        }
    }

    _cmp.imp = function (obj) {
        // 暂时写死导入模板的code
        var importcode = "";
        var vchtypeid = "";
        if ("import" == obj.code && _yearflag == "1") {
            importcode = "hbdeptindex001";
            vchtypeid = "1CCC505D4558BF55E063030011ACABFD";
        } else if ("importfunc" == obj.code && _yearflag == "1") {
            importcode = "hbdeptindex002";
            vchtypeid = "1CCC505D4559BF55E063030011ACABFD";
        } else if ("import" == obj.code && _yearflag == "0") {
            importcode = "hbdeptindex003";
            vchtypeid = "1CCC505D455ABF55E063030011ACABFD";
        } else if ("importfunc" == obj.code && _yearflag == "0") {
            importcode = "hbdeptindex004";
            vchtypeid = "1CCC505D455BBF55E063030011ACABFD";
        }
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.mainguid = _mainguid;
        params.yearflag = _yearflag;
        params.vchtypeid = vchtypeid;
        params.agencyguid = _saveAgency;
        params.type = obj.code;
        window.importparam = params;
        Ext.lt.importdata.imports(tokenid, importcode, vchtypeid, Object.toJSON(params), function () {
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.impsucess();
        });
    }

    Ext.lt.pmkpi.impsucess = function () {
        Ext.lt.ui.alert("导入成功！", function () {
            _cmp.query();
        });
    }

    return _cmp;
}
