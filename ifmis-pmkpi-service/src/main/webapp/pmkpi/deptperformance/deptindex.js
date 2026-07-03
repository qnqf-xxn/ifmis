if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptfunc){
    Ext.lt.pmkpi.deptfunc = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
Ext.lt.pmkpi.deptindex = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _viewtype = config.viewtype,
        _isnewapply = config.isnewapply, // 是否新填报方式
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid = config.busguid,//审核定义guid，perf_t_busauditdefine表budguid
        _ismergeindex = config.ismergeindex,//指标值是否合并展示
        indmap = config.indmap,//指标层次分类
        _signs = config.signs,//计算符号
        _kpivals = config["kpivals"], //合肥定量其他值.
        _kpicalnotapply = config["kpicalnotapply"],//不适用
        _isJiangXi = config["is_JiangXi"],
        _displaycols,
        _modelguid//指标模板guid
    ;
    var cmp = {};
    serviceid = service;
    _mainguid = config.mainguid;
    _saveAgency = config.saveAgency,
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        _modelguid = config.modelguid;
    });

    cmp.query = function(isquery){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.modelguid = _modelguid;
        params.isnewapply = _isnewapply;
        params.saveAgency = _saveAgency;
        params.viewtype = _viewtype;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setMidSaveHidButtons(rs);
            setTimeout(function(){
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        //if (!datatable.check()) return false;//先校验
        if (!cmp.checkAll()) return;//先校验
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
        var params = {};
        params.datas = tabledatas;
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        var tabledatas = datatable.getRecordSet().toArray();
        var params = {};
        params.data = tabledatas;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if(_isnewapply=="true"){
            newApplyHideBtns();
        }
        if (_viewtype == "query") {
            try{
                $("div[compid='toolbutton']").hide();
            }catch (e){
                document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
            cmp.setTableColum();
        }
        cmp.query(true);
        if (_isJiangXi == true && _viewtype != 'query'){
            cmp.recom(); //需求15486 江西要求进入指标先打开推荐
        }
    })

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];

            if(col["colcode"]=="obligate1"){
                if (_viewtype != "query"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if (data.levelno == "2"){
                            // html += '<a title = "选择" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexcheck("'+data.guid+'")\'>选择</a>';
                            // html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "新增" style="color:#468ac9;cursor:pointer;">新增</a>';
                        } else if(data.levelno == "3"){
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'","'+data._locationposition+'","'+data.sindex+'")\'>删除</a>';
                        }
                        if(_isnewapply=="true"){
                            return " ";
                        }else{
                            return html;
                        }
                    }
                    col.onclick = function(td, el, l, c, d) {
                        if(_isnewapply=="true"){
                            return;
                        }
                        var levelno = d.levelno;
                        if (levelno == "2"){
                            cmp.addrow(d.guid);
                            // cmp.add("",d.guid);
                        } /*else if (levelno == "3"){
                            Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
                                if(ret){
                                    eval(_onclickid).removeData(d);
                                }
                            });
                        }*/
                    };
                }
            }
            if(col["colcode"]=="indexval"){
                upcols.push(col["colcode"]);
                col.fn = function(l,c,data,col){
                    if(data.computesign == "6"|| data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1"){
                        var indexvalue = !data.indexval? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
                    } else {
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data["meterunit"]){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                    if(_isnewapply=="true" && d.value_change == "2"){ // 四个部门是否可编辑规则
                        return false;
                    }
                    if(d.computesign == "9"){ //合肥添加定量其他
                        Ext.lt.pmkpi.doMapper(_kpivals,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        Ext.lt.pmkpi.doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else {
                        el.innerText =  d.indexval!=undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                    }
                    // return;
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                        if(!checkReferencepole(d.indexval)){
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(d.indexval!=''){
                        var computesign = d.computesign;
                        if (!d.computesign) {
                            Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(d.computesign == "9"){
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }
            if(col["colcode"]=="weight"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var weight = 0;
                        if(data.weight){
                            weight = data.weight;
                        }
                        return "<b>"+Math.round(weight*100)/100+"</b>";
                    }else{
                        return data.weight ? data.weight : "";
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeight(d.superid);
                    amtTotal(datatable);
                }
            }
            if(col["colcode"]=="obligate3"){
                if (_viewtype != "query"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if(data.levelno == "2"){
                            // html += '<a title = "选择" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexcheck("'+data.guid+'")\'>选择</a>';
                            // html += '&nbsp;&nbsp;&nbsp;&nbsp';
                            html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'","'+data.findex+'")\'>新增</a>';
                        } else if(data.levelno == "3"){
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'","'+data._locationposition+'","'+data.sindex+'")\'>删除</a>';
                        }
                        return html;
                    }
                } else {
                    col.isvisiable = 0;
                }
            }
            if(col["colcode"]=="computesign"){
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10"){
                        if(d.indexval && !checkReferencepole(d.indexval)){
                            d.indexval = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "9") {
                        var istrue = false;
                        for (var i=0; i<_kpivals.length; i++) {
                            if (d.indexval == _kpivals[i].guid){
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            d.meterunit = '';
                            return false;
                        }
                    }else if (d.computesign && d.computesign == "10") {
                        var istrue = false;
                        for (var i=0; i<_kpicalnotapply.length; i++) {
                            if (d.indexval == _kpicalnotapply[i].guid){
                                istrue = true;
                            }
                        }
                        if (!istrue) {
                            d.indexval = '';
                            d.meterunit = '';
                            return false;
                        }
                    } else if (d.computesign && d.computesign == "6") {
                        d.indexval = '';
                        d.meterunit = '';
                        return false;
                    } else if (!d.computesign || d.computesign == "") {
                        d.indexval = '';
                        d.meterunit = '';
                        return false;
                    }
                }
            }
            if(col["colcode"]=="name" || col["colcode"]=="computesign" || col["colcode"]=="meterunit" || col["colcode"]=="kpi_remark"){
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if(_isnewapply=="true" || d.levelno != "3"){ // 四个部门不可编辑
                        return false;
                    }
                }
            }
            if (_viewtype == 'query' && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
        if (_viewtype != 'query') {
            for(var i=0; i<cols.length; i++){
                if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                    var iscol = false;
                    for (var j=0; j<upcols.length; j++) {
                        if (cols[i]["colcode"] == upcols[j]) {
                            iscol = true;
                            break;
                        }
                    }
                    if (!iscol) {
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            if(d.levelno != "3"){
                                return false;
                            }
                        }
                    }
                }
            }
        }
    });

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.levelno != 3){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    /**
     * 新增
     */
    cmp.addrow = function(selguid){
        var data = datatable.getRecordset().query({guid:selguid});
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var indexdata = {};
        indexdata.guid = createUUID().replace(/-/g, '');
        indexdata.saveAgency = _saveAgency; //项目单位
        indexdata.sindex = data[0].sindex;
        indexdata.findex = data[0].findex;
        indexdata.superid = data[0].sindex;
        indexdata.lv1_perf_ind_code = data[0].findex;
        indexdata.lv2_perf_ind_code = data[0].sindex;
        indexdata.lv1_perf_ind_name = data[0].findexname;
        indexdata.lv2_perf_ind_name = data[0].name;
        indexdata.levelno = 3;
        indexdata.isleaf = 1;
        indexdata._isleaf = 1;
        indexdata.rowtype = "add";
        datatable.getRecordSet().addData(indexdata,_sortid + datatable.getRecordset().toArray().length);
    }

    Ext.lt.pmkpi.addrow = function(data){
        datatable.getRecordSet().addData(data,999);
    }

    /**
     * 新增
     */
    cmp.add = function(obj,selguid){
        var data = [];
        if (!selguid) {
            data = cmp.getSeletdata("1");
            if(data.length != 1){
                Ext.lt.ui.alert("请选择一条二级指标！",function(){});
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid:selguid});
        }
        var _sortid = data[0]._sortid;
        if (data[0][FOLDING_FILED] == 'close') {
            data[0][FOLDING_FILED] = 'open';
            datatable.getViewRecordSet().showChildren(data[0], _sortid);
        }
        var url = '/pmkpi/deptperformance/report/editindex.page';
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth - 200, _scrHeight - 100,"新增指标");
    }
    /**
     * 修改
     */
    cmp.mod = function(){
        var data = cmp.getSeletdata("2");
        if(data.length != 1) {
            Ext.lt.ui.alert("请选择一个三级指标修改！",function(){});
            return;
        } else if (data.length == 1 && (!data[0].levelno || data[0].levelno != 3)) {
            Ext.lt.ui.alert("请选择三级指标修改！",function(){});
            return;
        }
        var url = "/pmkpi/deptperformance/report/editindex.page";
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.findex = data[0].findex;
        params.sindex = data[0].sindex;
        params.modguid = data[0].guid;
        params.type = "mod";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth - 200, _scrHeight - 100,"修改指标");
    }

    cmp.del = function (obj, selguid){
        var data = [];
        if (!selguid){
            data = datatable.getSelected();
            if(data.length == 0){
                Ext.lt.ui.alert("请选择需要删除的指标！",function(){});
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid:selguid});
        }
        Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
            if(ret){
                if (data && data.length>0) {
                    for(var i=0; i<data.length; i++){
                        if (data[i]["levelno"] == 3){
                            datatable.removeData(data[i]);
                        }
                    }
                }
            }
        })
    }

    /**
     * 表格的选择行.
     * @param type 1:包含二级，2 只有末级
     */
    cmp.getSeletdata = function(type){
        var _datas = datatable.getRecordSet().toArray();
        var seldata = [];
        var len = _datas.length;
        for ( var i = 0; i < len; i++) {
            if ("1" == type){
                if(_datas[i]["check"] == 1 && _datas[i]["levelno"] != 1){
                    seldata.push(_datas[i]);
                }
            } else if ("2" == type){
                if(_datas[i]["check"] == 1 && _datas[i]["levelno"] == 3){
                    seldata.push(_datas[i]);
                }
            } else {
                seldata.push(_datas[i]);
            }
        }
        return seldata;
    }

    /**
     * * 查看评审意见
     * */
    cmp.reviewinfo = function(){
        var params = {};
        var url = '/pmkpi/review/report/proindex.page';
        params.saveAgency = _saveAgency; //项目单位
        params.viewtype = "query";
        params.bustype = "dept";
        params.proguid = _mainguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"评审意见");
    }

    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function(datas) {
        var datas = datas || datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。");
                        return false;
                    }
                    if (cols[j].colcode == 'indexval' && value.match(RegExp("[*_-]")) != null) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }

    /**
     * 导入指标
     * @param obj
     */
    cmp.import = function(obj){
        // 暂时写死导入模板的code
        var importcode = "001001001";
        var vchtypeid = "C3C0E32D46E8D2FFE053B11FA8C09CE8";
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.proguid = _mainguid;
        params.pagetype = "add";
        params.agencyguid = _saveAgency;
        window.importparam = params;
        Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.impsucess();
        });
    }

    Ext.lt.pmkpi.impsucess = function (){
        Ext.lt.ui.alert("导入成功！", function () {
            Ext.lt.pmkpi.query();
        });
    }

    Ext.lt.pmkpi.query = function () {
        cmp.query();
    };

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
            if (col.colcode == "obligate1") {
                _displaycols.push(col); //隐藏前暂存至sfagency;
                col.display = false; //display置为false，隐藏
            }
        }
        datatable.redraw(); //从新绘制表格
    }

    /**
     * 精准推荐方法.
     */
    cmp.recom = function(){
        var url = '/pmkpi/deptperformance/deptperf/recomindex.page';
        var params = {};
        params.saveAgency = _saveAgency;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,_scrWidth-200,_scrHeight-100,"指标推荐");
    }

    /**
     * 复制上年指标
     */
    cmp.copylastyearindex = function (){
        var params = {};
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency; //部门编码
        params.copytype = 'index';//复制指标
        Ext.lt.ui.confirm("确认复制上年指标（仅累加不覆盖已有数据）？",{icon:"warn"},function(ret){
            if(ret){
                var rs = Ext.lt.RCP.asyncall(serviceid, "copyPerf", params);
                if(rs.success){
                    var perfindexdatatable = datatable;
                    var copyindex = rs.data;
                    var selMap = {};
                    var tempobj = {};
                    var sindex = "";
                    for(var i=0;i<copyindex.length;i++){
                        tempobj = copyindex[i];
                        tempobj.levelno = 3;
                        tempobj.isleaf = 1;
                        tempobj.rowtype = "add";
                        sindex = tempobj["sindex"];
                        if(!selMap[sindex]){
                            selMap[sindex] = [];
                        }
                        selMap[sindex].push(tempobj);
                    }
                    var ind_source = [];
                    for(var i=0; i<indmap.length; i++){
                        var temparr = [];
                        temparr.push(indmap[i]["guid"]);
                        temparr.push(indmap[i]["code"]);
                        temparr.push(indmap[i]["name"]);
                        ind_source.push(temparr);
                    }
                    perfindexdatatable.addMapperDatas("findex",ind_source);
                    perfindexdatatable.addMapperDatas("sindex",ind_source);
                    var zbxs_source = [];
                    for(var i=0; i<_signs.length; i++){
                        var temparr = [];
                        temparr.push(_signs[i]["guid"]);
                        temparr.push(_signs[i]["code"]);
                        temparr.push(_signs[i]["name"]);
                        zbxs_source.push(temparr);
                    }
                    perfindexdatatable.addMapperDatas("computesign",zbxs_source);
                    for (var key in selMap) {
                        var parent_sel_rows = perfindexdatatable.getRecordset().query({guid:key});
                        if (parent_sel_rows.length > 0 ) {
                            var parent_sel_obj = parent_sel_rows[parent_sel_rows.length -1];
                            var _sortid = parent_sel_obj._sortid;
                            perfindexdatatable.getRecordSet().addData(selMap[key],_sortid + perfindexdatatable.getRecordset().toArray().length);
                        }
                    }
                    perfindexdatatable.reflash();
                    Ext.lt.ui.alert("复制成功！",function(){});
                } else {
                    Ext.lt.ui.alert(rs.error,function(){});
                }
            }
        });
    }

    /**
     * 纳入指标库
     */
    cmp.intoindexlib = function (btnobj) {
        var datas = datatable.getSelected();
        if(datas.length == 0){
            Ext.lt.ui.alert("请选择纳入数据！",function(){});
            return;
        }
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        //if (!datatable.check()) return false;//先校验
        if (!cmp.checkAll(datas)) return;//先校验
        for (var a = 0, leni = datas.length; a < leni; a++) {
            if(datas[a].levelno == "3"){
                //校验空格
                if (!common.checkSpaceValue(datas[a],"绩效指标-第" + (datas[a]["_sortid"] + 1) + "行","datatable")) {
                    return;
                }
            }
        }
        var params = {};
        params.agency_code = _saveAgency;
        var btnconfig = eval("(" + btnobj.config + ")");
        var url = '/pmkpi/intoindexlib/index.page';
        params.bustype = "dept";
        params.workflow = btnconfig.workflow;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.95, _scrHeight * 0.95, "纳入指标库");
    }

    /**
     * 选择项目指标
     */
    cmp.proindex = function () {
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        var params = {};
        params.agency_code = _saveAgency;
        var url = '/pmkpi/dept/proindex.page';
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth * 0.95, _scrHeight * 0.95, "选择项目指标");
    }

    return cmp;
}

function indexcheck(guid) {
    var url = "/pmkpi/deptperformance/report/indexcheck.page";
    var params = {};
    params.sindex = guid;
    params.saveAgency = _saveAgency;
    params.mainguid = _mainguid;
    url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url,_scrWidth - 200, _scrHeight - 100,"选择指标");
}

function indexadd(sindex,findex) {
    var data = {};
    var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
    data.guid = newguid;
    data.rowtype = "add";
    data.mainguid = _mainguid;
    data.sindex = sindex;
    data.findex = findex;
    data.superid = sindex;
    data.levelno = 3;
    data.isleaf = 1;
    data._isleaf = 1;
    Ext.lt.pmkpi.isadd = true;
    datatable.getRecordSet().addData(data,999);
}

function indexdel(guid,_locationposition,sindex) {
    Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
        if(ret){
            var datas = datatable.getRecordSet().toArray();
            if(datas!=null && datas.length > 0) {
                for (var i = 0; i < datas.length; i++) {
                    var selectDatas = datas[i];
                    if (guid == selectDatas.guid) {
                        datatable.removeData(selectDatas);
                    }
                }
            }
            gatherWeight(sindex);
        }
    });
}

function gatherWeight(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)){
                    result += parseFloat(selectDatas.weight);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid){
                    datas[i]['weight'] = result==0 ? "" : result.toFixed(2);
                }
            });
            gatherWeight(supguid);
            amtTotal(datatable);
        }
    }
    datatable.reflash();
}

function amtTotal(table) {
    if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var sumamt = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumamt += parseFloat(weight);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                sumamt += parseFloat(weight);
            }
        }
        var totalrs = {};
        totalrs["weight"] = sumamt == 0 ? "" : sumamt.toFixed(2);
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        }
    }
}

/**
 *
 * @param hidebtns
 */
function newApplyHideBtns(){
    if(toolbutton){
        var buttons = toolbutton.cfg.data.buttons;
        for(var i=0,length = buttons.length;i<length;i++){
            var btn = buttons[i];
            toolbutton.hidden(btn.name); //隐藏所有按钮
        }
    }
}