if(!Ext)
    Ext = {};
if(!Ext.lt)
    Ext.lt = {};
if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.prorevision)
    Ext.lt.pmkpi.prorevision = {};
/**
 * 初始化加载.
 */
var _prolev;
var _saveAgency;
var ismergeindex = "1";
var _curtab = ""; //当前页签.
var tabcomps;
var showtab;
var mainguid;
var _isedittotal;
Ext.lt.pmkpi.prorevision.indexservice = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _mainguid = config["mainguid"];
    var _viewtype = config["viewtype"]; //修改还是查看
    _saveAgency = config["saveAgency"]; //项目单位
    _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _procode = config["procode"];
    var _pro_name = config.pro_name;
    var _signs = config["signs"];//指标符号
    var _kpivals = config["kpivals"]; //合肥定量其他值.
    var _kpicalnotapply = config["kpicalnotapply"];//不适用
    ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    isZJ = config["isZJ"];//标识是否是浙江（1.浙江）
    var _busguid = config.busguid;//审核定义guid
    _prolev = config["prolev"]; //项目等级123级项目
    var _cmp = {};
    tabcomps = config["indexdata"]; //总体的指标数据.
    tabcomps["del#total"] = []; //总体删除
    tabcomps["del#year"] = []; //年度删除
    showtab = config.showtab; //页签展示

    var hideIframeHtml = "";
    var height = $(window).height()*0.9;
    var width = $(window).width()*0.9;
    var _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var tabnum = 0; //页签点击次数
    var pdmsave = config.pdmsave;//暂存方法.
    var _displaycols = [];
    //页面加载完成后执行
    $(function() {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        //_cmp.init();
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#datatable").append(hideIframeHtml);
        }
        _cmp.bulidTopHead();
        if (_viewtype == "query" || (_isedittotal == '1' && (_curtab == "" || _curtab == "total"))) {
            $("div[compid='toolbutton']").hide();
            for(var i = 2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            datatable.redraw();
        }
        if (showtab == "3"){ //处理年度显示的时候
            _curtab = "year";
        }
        var tempdata = tabcomps["#"+_curtab];
        datatable.setDatas(tempdata);
        parent._isQuery = true;
        _cmp.setTableColum();
    });

    /**
     * tabpage转radio
     */
    _cmp.bulidTopHead = function (){
        var tabpagedatas = tabpage.cfg.data;
        $("#tabpage").hide();
        var topheadHtml = [];
        topheadHtml.push("<div id='tophead' style='display:block;overflow:hidden;font-size:15px;height:45px;'>");
        topheadHtml.push("<div id='topheadcontent' style='width:70%;float:left;padding-top:5px;'>&nbsp;&nbsp;&nbsp;&nbsp;");
        if(tabpagedatas.length == 1){
            var tabdata = tabpagedatas[0];
            topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
        }else if(tabpagedatas.length > 1){
            for(var i=0;i<tabpagedatas.length;i++) {
                var tabdata = tabpagedatas[i];
                var ischecked = tabdata.classname;
                if(ischecked == "choosed"){
                    topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio' checked>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
                }else{
                    topheadHtml.push("<label style='cursor:pointer'><input name='checktab' id='"+tabdata.code+"' value='"+tabdata.name+"' hidebtns='"+tabdata.hidebtns+"' type='radio'>&nbsp;"+tabdata.title+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>")
                }
            }
        }
        topheadHtml.push("</div>");
        topheadHtml.push("</div>");
        $(".bd_main").children().first().before(topheadHtml.join(''));
        $("input[type='radio'][name='checktab']").click(function () {
            _cmp.checktabRadioClick();
        });
    }

    /**
     * radio点击触发clickTabpage
     */
    _cmp.checktabRadioClick = function(){
        var checktab = $("input[name='checktab']:checked");
        var checkcode = checktab.attr("id");
        var checkname = checktab.attr("value");
        var hidebtns = checktab.attr("hidebtns");
        var tabobj = {};
        tabobj.code = checkcode;
        tabobj.name = checkname;
        tabobj.hidebtns = hidebtns;
        _cmp.clickTabpage(tabobj);
    }

    /**
     * 点击页签.
     */
    _cmp.clickTabpage = function(obj){
        if (showtab != 1) {
            toolbutton.hidden("copytotalindex");
        }
        if (showtab == 3){
            _curtab = "year";
        }
        if (showtab == 2){
            $("#tabpage").find('li').eq(1).hide();
        }
        if(tabnum != 0  && _curtab != obj.code && showtab != 3){
            var num = 1;
            if (_curtab == "total"){
                num = 0;
            }
            if ((_isedittotal != "1" || _curtab == "year") && _viewtype != "query" && !_cmp.checkAll()) {
                tabpage.doActiveTab(num);
                return;//先校验
            }
            var tempdata =  datatable.getRecordSet().toArray();
            if(tempdata.length>0){
                if (obj.code == "year"){
                    tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
                } else {
                    tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
                }
                var tempdata = tabcomps["#"+obj.code];
                datatable.setDatas(tempdata);
            }
        }
        _curtab = obj.code;
        tabnum ++;
        $("div[compid='toolbutton']").show();
        for(var i = 2; i<datatable.getCols().length; i++){
            datatable.getCols()[i].edit = true;
        }
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        if (_isedittotal == "1" && _curtab == "total") {
            $("div[compid='toolbutton']").hide();
            for(var i = 2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
        }
        _cmp.setTableColum();
    }

    /**
     * 复制总体指标
     */
    Ext.lt.pmkpi.copytotalindex = function(){
        var data;
        if (_curtab == "total") {
            data = datatable.getSelected();
            if(data.length == 0){
                Ext.lt.ui.confirm("是否对总体绩效指标进行整体复制？",{icon:"warn"},function(ret){
                    if(ret){
                        data =  datatable.getRecordSet().toArray();
                        setYeardata(data);
                    }
                })
            } else {
                Ext.lt.ui.confirm("是否复制选中绩效指标？",{icon:"warn"},function(ret){
                    if(ret){
                        setYeardata(data);
                    }
                })
            }
        } else {
            Ext.lt.ui.confirm("是否对总体绩效指标进行整体复制？",{icon:"warn"},function(ret){
                if(ret){
                    data =  tabcomps["#total"];
                    if(data == null || data.length == 0){
                        alert("未读取到总体指标，请刷新页面重试！");
                        return;
                    }
                    setYeardata(data);
                }
            })
        }
    }

    function setYeardata(data){
        var yeardatas = Ext.lt.cloneobj(data);
        for (var i=0; i<yeardatas.length; i++) {
            yeardatas[i]["busi_type_code"] = "2";
            if (yeardatas[i].levelno == 3) {
                var params = {};
                for (var key in yeardatas[i]) {
                    params[key] =  yeardatas[i][key];
                }
                params.rowtype = "add";
                params.isfixed = "";
                params['guid'] = getCreateguid(serviceid);
                tabcomps["#year"].push(params);
            }
        }
        Ext.lt.ui.alert("复制成功！",function(){
            if (_curtab == "year") {
                var tempdata = tabcomps["#"+_curtab];
                datatable.setDatas(tempdata);
            }
        });
    }

    /**
     * 页面初始化.
     */
    _cmp.init = function(){
        var params = {};
        if(mainguid!=null){
            _mainguid = mainguid;
        }
        params.proguid = _proguid;
        params.showtab = showtab;
        params.pdmsave = pdmsave;
        params.mainguid = _mainguid;
        params.prolev = _prolev;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "findAllIndex", [params], function(data) {
            tabcomps = data;
            tabcomps["del#total"] = []; //总体删除
            tabcomps["del#year"] = []; //年度删除
            var tempdata = tabcomps["#"+_curtab];
            datatable.setDatas(tempdata);
            setTimeout(function(){
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
        })
    }

    /**
     * 新增
     */
    _cmp.add = function(obj,selguid){
        var data = [];
        if (!selguid) {
            data = _cmp.getSeletdata("1");
            if(data.length != 1){
                Ext.lt.ui.alert("请选择一条二级指标！",function(){});
                return;
            }
        } else {
            data = datatable.getRecordset().query({guid:selguid});
        }
        var url = '/pmkpi/program/prjindex/editindex.page';
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.sindex = data[0].sindex;
        params.upguid = data[0].guid;
        params.type = "add";
        params.fromtype = "tree";
        params.isfixed = "";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"新增指标");
    }

    /**
     * 新增行
     */
    _cmp.addrow = function(selguid){
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
        indexdata.levelno = 3;
        indexdata.isleaf = 1;
        indexdata._isleaf = 1;
        indexdata.rowtype = "add";
        indexdata.isfixed = "";
        if(isZJ == 1){
            indexdata.is_add = "1";
        }
        datatable.getRecordSet().addData(indexdata,_sortid + datatable.getRecordset().toArray().length);
    }

    /**
     * 修改
     */
    _cmp.mod = function(){
        var data = _cmp.getSeletdata("2");
        if(data.length != 1) {
            Ext.lt.ui.alert("请选择一个三级指标修改！",function(){});
            return;
        } else if (data.length == 1 && (!data[0].levelno || data[0].levelno != 3)) {
            Ext.lt.ui.alert("请选择三级指标修改！",function(){});
            return;
        }
        var url = '/pmkpi/program/prjindex/editindex.page';
        var params = {};
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.sindex = data[0].sindex;
        params.modguid = data[0].guid;
        params.type = "mod";
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"修改指标");
    }
    /**
     * 删除.
     * @param selguid -- 选中行
     */
    _cmp.del = function(obj,selguid){
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
        for(var i=0; i<data.length; i++){
            if(data[i].isfixed == "1"){
                Ext.lt.ui.alert("固化指标无法删除！",function(){});
                return;
            }
        }
        Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
            if(ret){
                if (data && data.length>0) {
                    var guids = [];
                    var superguid = [];
                    var delguids = [];//原来存在要物理删除的数据
                    for(var i=0; i<data.length; i++){
                        if (data[i]["levelno"] == 3){
                            guids.push(data[i]["guid"]);
                            if (superguid.indexOf(data[i]["superid"]) < 0){
                                superguid.push(data[i]["superid"]);
                            }
                        }
                        if (data[i]["levelno"]=="3" && data[i]["rowtype"] != "add") {
                            delguids.push(data[i]["guid"]);
                        }
                    }
                    if (delguids.length > 0){ //记录整体还是年度删除的数据.
                        var tempArr = [];
                        if (_curtab == "total"){ //总体
                            tempArr = tabcomps["del#total"];
                            tabcomps["del#total"] = tempArr.concat(delguids); //总体删除
                        } else {
                            tempArr = tabcomps["del#year"];
                            tabcomps["del#year"] = tempArr.concat(delguids); //年度删除
                        }
                    }
                    datatable.remove({guid:guids});
                    if (superguid.length > 0){ //判断是否还有下级科目，没有isleaf置1
                        _cmp.upSuperIslef(superguid);
                    }
                    // if (_curtab == "year"){ //总体
                    //删除同步处理tabcomps数据集合（不处理会影响复制功能）
                    var tempdata =  datatable.getAllData();
                    tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
                    // }
                }
            }
        })
    }
    /**
     * 保存方法.
     */
    _cmp.save = function(obj){
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        if (!_cmp.checkAll()) return;//先校验
        //保存之前存放当前最后一次
        var tempdata =  datatable.getAllData();
        tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
        var params = {};
        params.proguid = _proguid;
        params.datas = tabcomps;
        params.mainguid = _mainguid;
        mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.prolev = _prolev;//项目级别 123
        params.showtab = showtab; //展示的目标数
        params.procode = _procode; //项目编码
        params.pro_name = _pro_name;
        params.isedittotal = _isedittotal;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "savePrjTreeIndex", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            setTimeout(function(){
                _cmp.init();
            },100);
        }
        return rs;
    }
    /**
     * 精准推荐方法.
     */
    _cmp.recom = function(){
        var url = '/pmkpi/program/prjindex/recomindex.page';
        var params = {};
        params.proguid = _proguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        params.showtab = showtab;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"指标推荐");
    }
    /**
     * 挑选指标.
     * frame -- 二级指标
     * guid -- guid
     */
    _cmp.pick = function(){
        var data = _cmp.getSeletdata("1");
        var url = '/pmkpi/program/prjindex/pickindex.page';
        var params = {};
        if(data.length > 0){
            params.sindex = data[0].sindex;
            params.guid = data[0].guid;
        }
        params.fromtype = "tree";//树级填报
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"挑选指标");
    }
    /**
     * 复制上年指标.
     */
    _cmp.lastyear = function(){
        var params = {};
        var url = '/pmkpi/program/prjindex/lastyear.page';
        params.fromtype = "tree";//树级填报
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"上年指标");
    }
    /**
     * 往年预算执行情况.
     */
    _cmp.budget = function(){
        var params = {};
        var url = '/pmkpi/program/prjindex/budget.page';
        params.fromtype = "tree";//树级填报
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.proguid = _proguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"往年预算执行情况");
    }
    /**
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="indexval"){
                upcols.push(col["colcode"]);
                col.fn = function(l,c,data,col){
                    if(data.computesign == "6"|| data.computesign == "9" || data.computesign == "10" || ismergeindex != "1"){
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
                    if (_isedittotal == "1" && _curtab == "total") {
                        return false;
                    }
                    if(d.levelno != "3"){
                        return false;
                    }
                    if(!d.indexval || d.indexval != ''){
                        if (!d.computesign || d.computesign == "") {
                            Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(d.computesign == "9"){ //合肥添加定量其他
                        doMapper(_kpivals,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    }else if(d.computesign == "10"){
                        doMapper(_kpicalnotapply,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
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
                    if(d.computesign == "9"){
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }
            if(col["colcode"]=="obligate1"){
                if (_viewtype != "query"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if(data.levelno == "2"){
                            html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:revisionindex.addrow("'+data.guid+'")\'>新增</a>';
                        } else if(data.levelno == "3"){
                            html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:revisionindex.del("","'+data.guid+'")\'>删除</a>';
                        }
                        if(_isedittotal == "1" && _curtab == "total"){
                            return "";
                        }else{
                            return html;
                        }
                    }
                } else {
                    col.isvisiable = 0;
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
                    if(d.levelno == "3" && d.rowtype!="add"){
                        d.rowtype ="mod";
                    }
                    gatherWeight(d.superid);
                    amtTotal(datatable);
                }
            }
            if(col["colcode"]=="computesign"){
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != "9" && d.computesign != "10"){
                        if(d.indexval && !checkReferencepole(d.indexval)){
                            d.indexval = '';
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
                    } else if (d.computesign && d.computesign == "10") {
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
                        cols[i].oneditstart = function(table,el,l,c,d){
                            if (_isedittotal == "1" && _curtab == "total") {
                                return false;
                            }
                            if(d.levelno != "3"){
                                return false;
                            }
                            if (d.isfixed == "1") { // 固化指标不可编辑
                                return false;
                            }
                        }
                        cols[i].oneditend = function (table, el, l, c, d) {
                            if(d.levelno == "3" && d.rowtype!="add"){
                                d.rowtype ="mod";
                            }
                        }
                    }
                }
            }
        }
    })

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.levelno != 3 || (_isedittotal == "1" && _curtab == "total")){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

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

    /**
     * 表格的选择行.
     * @param type 1:包含二级，2 只有末级
     */
    _cmp.getSeletdata = function(type){
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
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    _cmp.checkAll = function() {
        var datas = datatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if (datas[i]["levelno"] == 3) {
                if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。",{timeout:1},function(){});
                    return;
                }
                if(datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')){
                    Ext.lt.ui.alert("计算符号选择“定量（其他）”时，指标值说明必填！",{timeout:1},function(){});
                    return;
                }
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                    if (cols[j].colcode == 'indexval' && value.match(RegExp("[*_-]")) != null && (_curtab == "year" || (_isedittotal != "1" && _curtab == "total"))) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }
    /**
     *
     * @param superids -- 要判断的二级.
     */
    _cmp.upSuperIslef = function(superids){
        var datas = datatable.getRecordSet().toArray();
        var isUpdate = true;
        if(datas!=null && datas.length > 0){
            var lev2arr = [];
            var seltDatas = {};
            for(var i=0;i<datas.length;i++){
                seltDatas = datas[i];
                if(seltDatas.superid != "" && seltDatas.levelno == 3 && lev2arr.indexOf(seltDatas["superid"]) < 0){
                    lev2arr.push(seltDatas.superid);
                }
            }
            if (superids.length > 0) {
                var suprow = {};
                for(var i=0;i<superids.length;i++){
                    if (lev2arr.indexOf(superids[i]) < 0){
                        suprow = datatable.getRecordset().query({guid:superids[i]})[0];
                        suprow['isleaf'] = '1';
                        suprow['_isleaf'] = '1';
                        var _sortid = suprow._sortid;
                        datatable.reflash(_sortid);
                    }
                }
                //datatable.reflash();
            }
        }
    }

    /**
     * * 复查看评审意见
     * */
    _cmp.reviewinfo = function(){
        var params = {};
        var url = '/pmkpi/review/report/proindex.page';
        params.saveAgency = _saveAgency; //项目单位
        params.viewtype = "query";
        params.bustype = "PROGRAM";
        params.mainguid = _proguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"评审意见");
    }

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
            if (col.colcode == "opinion_remark") {
                col.edit = config[col.colcode];
            }
            if (_viewtype == "query" || (_isedittotal == "1" && _curtab == "total")) {
                if (col.colcode == "obligate1") {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            } else if (col.colcode == "obligate1") {
                col.display = true;
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    return _cmp;


}

/**
 * 动态改变列的属性.
 * @param rs
 * @param col
 */
function doMapper(rs,col){
    var mapping = [];
    var columns = [];
    for(var i =0; i<rs.size() ; i++){
        var arr = [];
        arr.push(rs[i].guid);
        arr.push(rs[i].code);
        arr.push(rs[i].name);
        columns.push(arr);
        mapping[rs[i].code] = arr;
    }
    col.mapping = mapping;
    col.mapper = {} ;
    col.mapper.columns = ['guid','code','name','supcode','pinyin'];
    col.mapper.datas = columns ;
    col.mapper.regs = ['#guid','#code','#name','#supcode','#pinyin'];
    col.mapper.default_column = 'code';
    col.format = '#name';
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