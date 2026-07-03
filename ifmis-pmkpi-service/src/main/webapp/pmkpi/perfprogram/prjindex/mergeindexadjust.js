if(!Ext)
    Ext = {};
if(!Ext.lt)
    Ext.lt = {};
if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _prolev;
var _saveAgency;
var ismergeindex = "1";
var _curtab = ""; //当前页签.
var tabcomps;
var showtab;
var listdiv = null;
var _datatype;
var _noadjust;
var _scrWidth =document.body.clientWidth,
    _scrHeight =document.body.clientHeight;
Ext.lt.pmkpi.treeindexadjust = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _procode = config["procode"];
    var _viewtype = config["viewtype"]; //修改还是查看
    _saveAgency = config["saveAgency"]; //项目单位
    var _isbefore = config["isbefore"]; // 1显示事前评估，2 不显示
    var _signs = config["signs"];//指标符号
    var _kpivals = config["kpivals"]; //合肥定量其他值.
    var _noreadonly = config["noreadonly"]; //空为查看，1为编辑
    ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    var _busguid = config.busguid;//审核定义guid
    var procat = config["procat"]; //类别
    var _setyear = config["setyear"];
    var _admdiv = config["admdiv"];
    var _ISXZZD = config["ISXZZD"];
    var _usercode = config["usercode"];
    var _tempatecode = config.tempatecode;//导出报告模板code
    var _pmkpidatatype = config.pmkpidatatype;//数据类型
    _datatype = config.datatype;
    var _cmp = {};
    tabcomps = config["indexdata"]; //总体的指标数据.
    tabcomps["del#total"] = []; //总体删除
    tabcomps["del#year"] = []; //年度删除
    _noadjust = tabcomps["#noadjust"];
    showtab = config.showtab; //页签展示
    var _displaycols = [];
    var hideIframeHtml = "";
    height = $(window).height()*0.9;
    width = $(window).width()*0.9;
    var _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _prjindexcoldatas = config["prjindexcoldatas"];//表格列
    var tabnum = 0; //页签点击次数
    var _state = config.state;//贵州 1新增2修改，3查看
    var _adjmainguid;
    var contweight,contheight;
    var _reporttype = config.reporttype;
    //页面加载完成后执行
    $(function() {
        if(_noadjust && _noadjust == "1"){
            Ext.lt.ui.alert("绩效目标调整在途，不能重复发起！",function(){
                // document.getElementById("toolbutton").style.display = "hidden";
                $("#toolbutton").hide();
                $("button").hide();
                _viewtype = "query";
            });
        }
        _adjmainguid = tabcomps["#adjmainguid"];
        var tempdata = tabcomps["#"+_curtab]; //绩效指标
        datatable.setDatas(tempdata);
        var goaldata = tabcomps["#goal"+_curtab];//绩效目标
        editform.synchEditformByObj(goaldata);
        contweight = $("#datatable").width();
        contheight = $("#toolbutton").height() + $("#editform").height() + $("#datatable").height() + 11;
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
            if (_state != "3" && !_noreadonly && _reporttype != "1"){
                $('.layui-tab-title').append("<button title='填报绩效' onclick=\"addperformance();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">填报绩效</button>");
            }
            if(_noreadonly =="1" && (procat == "1" || procat=="3")){
                $('.layui-tab-title').append("<button title='保存' onclick=\"savealltab();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">保存</button>");
            }
            if (_state == "3" && _reporttype != "1"){
                $('.layui-tab-title').append("<button id='exportindex' title='导出指标' onclick=\"exportIndexFile();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\"></button>");
                if(_curtab == "total"){
                    $("#exportindex").text("导出总体指标");
                }else if(_curtab == "year") {
                    $("#exportindex").text("导出年度指标");
                }else {
                    $("#exportindex").hide();
                }
            }
            editform.setdisabled({kpi_target:true});
            for(var i = 2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            if(_curtab == "total"){
                _cmp.setTableColum(false);
                editform.hide(['adjustndgoal','adjustremark'],false);
                if ($("div[compid='toolbutton']")){
                    $("div[compid='toolbutton']").hide();
                }
            }else {
                editform.show(['adjustndgoal','adjustremark'],false);
                if ($("div[compid='toolbutton']")){
                    $("div[compid='toolbutton']").show();
                }
            }
        } else {
            $('.layui-tab-title').append("<button id='savetabonly' title='保存' onclick=\"savealltab();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">保存</button>");
            if(_curtab == "total"){
                _cmp.setTableColum(false);
                editform.hide(['adjustndgoal','adjustremark'],false);
                $("#editform").find("textarea[name='kpi_target']").prev().children("font").html("总体绩效目标");
                if ($("div[compid='toolbutton']")){
                    $("div[compid='toolbutton']").hide();
                }
            }else {
                _cmp.setTableColum(true);
                editform.show(['adjustndgoal','adjustremark'],false);
                $("#editform").find("textarea[name='kpi_target']").prev().children("font").html("调整前年度绩效目标");
                if ($("div[compid='toolbutton']")){
                    $("div[compid='toolbutton']").show();
                }
            }
            datatable.redraw();
        }
    });

    /**
     * 点击页签.
     */
    _cmp.clickTabpage = function(obj){
        if(_noadjust && _noadjust == "1"){
            _viewtype = "query";
        }
        if (_state == "3" && _reporttype != "1"){
            if(obj.code == "total"){
                $("#exportindex").text("导出总体指标");
                if ($("div[compid='toolbutton']")){
                    $("div[compid='toolbutton']").hide();
                }
            }else if(obj.code == "year") {
                $("#exportindex").text("导出年度指标");
                if ($("div[compid='toolbutton']")){
                    $("div[compid='toolbutton']").show();
                }
            }else {
                $("#exportindex").hide();
            }
        }
        if(showtab == "1" && obj.code == "year"){
            if ($("div[compid='toolbutton']")){
                $("div[compid='toolbutton']").show();
            }
        }
        if (document.getElementById("editform")){
            document.getElementById("editform").style.display = "block";
        }
        if (document.getElementById("datatable")){
            document.getElementById("datatable").style.display = "block";
            if(tabnum != 0 ){
                datatable.resize(contweight,contheight);
            }else{
                contweight = $("#datatable").width();
                contheight = $("#toolbutton").height() + $("#editform").height() + $("#datatable").height() + 11;
            }
        }
        if(showtab == "1" && obj.code == "total"){
            var tabconfig = eval('(' + obj.config + ')');
            var hideBtn = tabconfig.hidebtn;
            if(hideBtn != undefined && hideBtn != ""){
                var hideBtnArr = hideBtn.split(",");
                toolbutton.hidden(hideBtnArr);
            }
        }else {
            common.changTooltoolbuttontStatus(0,obj.hidebtns);
        }
        if (_viewtype != "query"){
            if(tabnum != 0  && _curtab != obj.code && _curtab != "before"){ //非事前
                if (!_cmp.checkAll() || !editform.check()) {
                    var num = 0;
                    if (_curtab == "year"){
                        num = 1;
                    }
                    var tempdata =  datatable.getRecordSet().toArray();
                    var goaldata =  editform.getEditFormValues();
                    if (_curtab == "year"){
                        tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
                        tabcomps["#goalyear"] =Ext.lt.cloneobj(goaldata);
                    } else {
                        tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
                        tabcomps["#goaltotal"] =Ext.lt.cloneobj(goaldata);
                    }
                    tabpage.doActiveTab(num);
                    return;//先校验
                }
                var tempdata =  datatable.getRecordSet().toArray();
                var goaldata =  editform.getEditFormValues();
                if (_curtab == "year"){
                    tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
                    tabcomps["#goalyear"] =Ext.lt.cloneobj(goaldata);
                } else {
                    tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
                    tabcomps["#goaltotal"] =Ext.lt.cloneobj(goaldata);
                }
            }
        }
        if (obj.code != "before" && tabnum != 0){
            var tempdata = tabcomps["#"+obj.code]; //绩效指标
            var goaldata = tabcomps["#goal"+obj.code];//绩效目标
            datatable.setDatas(tempdata);
            if (goaldata) {
                editform.synchEditformByObj(goaldata);
            } else {
                goaldata = {};
                goaldata.kpi_target = "";
                editform.synchEditformByObj(goaldata);
            }
            if(obj.code == "total"){
                _cmp.setTableColum(false);
                editform.hide(['adjustndgoal','adjustremark'],false);
                $("#editform").find("textarea[name='kpi_target']").prev().children("font").html("总体绩效目标");
            }else {
                _cmp.setTableColum(true);
                editform.show(['adjustndgoal','adjustremark'],false);
                $("#editform").find("textarea[name='kpi_target']").prev().children("font").html("调整前年度绩效目标");
            }
        }
        if (_viewtype == "query" && tabnum != 0) {
            $("div[compid='toolbutton']").hide();
            editform.setdisabled({kpi_target:true});
            editform.setdisabled({adjustndgoal:true,adjustremark:true});
        }
        _curtab = obj.code;
        tabnum ++;
        Ext.lt.message.send("datatable", 'beforesetcols', {
            table: datatable,
            cols: _prjindexcoldatas
        });
        setTimeout(function(){
            datatable.setSelfdefconfig({config: "{}"});
            datatable.redraw();
            changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns); //隐藏按钮
            if(showtab == "1" && obj.code == "total"){
                var tabconfig = eval('(' + obj.config + ')');
                var hideBtn = tabconfig.hidebtn;
                if(hideBtn != undefined && hideBtn != ""){
                    var hideBtnArr = hideBtn.split(",");
                    toolbutton.hidden(hideBtnArr);
                }
            }else {
                setTimeout(function(){
                    datatable.resize(contweight,contheight);
                },120);
                common.changTooltoolbuttontStatus(0,obj.hidebtns);
            }
        },120);
        if(_noadjust && _noadjust == "1"){
            $("#toolbutton").hide();
            $("button").hide();
        }
    }

    /**
     * 复制总体指标
     */
    Ext.lt.pmkpi.copytotalindex = function(){
        Ext.lt.ui.confirm("是否对总体绩效指标进行整体复制？",{icon:"warn"},function(ret){
            if(ret){
                var data =  tabcomps["#total"];
                //处理绩效目标
                var goaldata = tabcomps["#goaltotal"];//绩效目标
                var tempgoal = editform.getEditFormValues(); //年度有值覆盖
                if(tempgoal["kpi_target"] && tempgoal["kpi_target"] != "" && (procat == "1" || procat=="3")){
                    alert("年度绩效已经存在不能重复点击复制总体按钮！");
                    return;
                }
                tempgoal.adjustndgoal = goaldata.kpi_target;
                editform.synchEditformByObj(tempgoal);
                var yeargoaltemp = editform.getEditFormValues(); //年度有值覆盖
                tabcomps["#goalyear"] =Ext.lt.cloneobj(yeargoaltemp);
                //end;
                setYeardata(data);
            }
        })
    }

    function setYeardata(data){
        var yeardatas = Ext.lt.cloneobj(data);
        for (var i=0; i<yeardatas.length; i++) {
            if (yeardatas[i]["name"] =="项目或定额成本控制率" && (procat =="4" || procat == "5")){
                continue;
            }
            if (yeardatas[i].levelno == 3) {
                if(!yeardatas[i].status){
                    yeardatas[i].status ='3';
                }else{
                    yeardatas[i].status ='';
                }
                var params = {};
                for (var key in yeardatas[i]) {
                    params[key] =  yeardatas[i][key];
                }
                params.rowtype = "add";
                params['guid'] = getCreateguid(serviceid);
                params.perf_obj_type_code = "2";
                params.perf_obj_type_name = "项目年度绩效";
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

    _cmp.setTableColum = function (isShow) {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col.colcode == "obligate1" || col.colcode == "status" || col.colcode =="adjustindexval") {
                if(!isShow){
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                }
                col.display = isShow; //display置为false，隐藏
            }
        }
    }

    /**
     * 页面初始化.
     */
    _cmp.init = function(){
        var params = {};
        params.proguid = _proguid;
        params.procode = _procode;
        params.adjmainguid = _adjmainguid;
        params.showtab = showtab;
        params.isbefore = _isbefore;
        params.viewtype = _viewtype;
        params.reporttype = _reporttype;
        //Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "findAllIndex", [params], function(data) {
            tabcomps = data;
            tabcomps["del#total"] = []; //总体删除
            tabcomps["del#year"] = []; //年度删除
            if (_curtab == "total" || _curtab == "year" ) {
                var tempdata = tabcomps["#"+_curtab];
                datatable.setDatas(tempdata);
                var goaldata = tabcomps["#goal"+_curtab];//绩效目标
                if (goaldata) {
                    editform.synchEditformByObj(goaldata);
                } else {
                    goaldata = {};
                    goaldata.kpi_target = "";
                    editform.synchEditformByObj(goaldata);
                }
            }
        })
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
        if(data[0].code == '149999' || data[0].name == '项目或定额成本控制率'){
            Ext.lt.ui.alert("此条三级指标不可删除！",function(){});
            return;
        }
        Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
            if(ret){
                if (data && data.length>0) {
                    var guids = [];
                    var superguid = [];
                    var delguids = [];//原来存在要物理删除的数据
                    getdataSource();
                    for(var i=0; i<data.length; i++){
                        var parent_sel_rows = datatable.getRecordset().query({guid: data[i].guid});
                        var parent_sel_obj = parent_sel_rows[0];
                        if (parent_sel_obj.levelno == 3) {
                            if (parent_sel_obj.status == 3) {
                                datatable.removeData(parent_sel_obj);
                            } else {
                                var _sortid = parent_sel_obj._sortid;
                                parent_sel_obj.status = 1;
                                parent_sel_obj.obligate1 = "撤销删除";
                                $.extend(parent_sel_obj, parent_sel_obj); //合并值集刷新
                                datatable.reflash(_sortid);
                            }
                        }
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
                    // datatable.remove({guid:guids});
                    // if (superguid.length > 0){ //判断是否还有下级科目，没有isleaf置1
                    //     _cmp.upSuperIslef(superguid);
                    // }
					//删除同步处理tabcomps数据集合（不处理会影响复制功能）
                    var tempdata =  datatable.getAllData();
                    tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
                }
            }
        })
    }

    _cmp.saveCheck = function () {
        var datas = datatable.getRecordSet().toArray();
        var yearflag = "";
        var alertmsg = "";
        for (var i=0; i<datas.length; i++) {
            if (datas[i].levelno == 3 && datas[i].yearflag) {
                yearflag = datas[i].yearflag;
                break;
            }
        }
        //校验没问题，插入数据
        if (yearflag == "1"){
            tabcomps["#total"] = Ext.lt.cloneobj(datas);
        } else if (yearflag == "0") {
            tabcomps["#year"] =Ext.lt.cloneobj(datas);
        }
        var tatalindex = tabcomps["#total"];
        var yearindex = tabcomps["#year"];
        for(var i=0;i<tatalindex.length;i++) {
            if(tatalindex[i]["levelno"] == 3 && tatalindex[i].yearflag != "1"){
                alertmsg= "【总体指标】三级指标：" + tatalindex[i].name + "录入不正确，请删除后重新录入!";
                Ext.lt.ui.alert(alertmsg, {timeout:1},function(){});
                return false;
            }
        }
        for(var i=0;i<yearindex.length;i++) {
            if(yearindex[i]["levelno"] == 3 && yearindex[i].yearflag != "0"){
                alertmsg= "【年度指标】三级指标：" + yearindex[i].name + "录入不正确，请删除后重新录入!";
                Ext.lt.ui.alert(alertmsg, {timeout:1},function(){});
                return false;
            }
        }
        return true;
    }

    /**
     * 页面自己单独的保存.
     */
    savealltab = function(){
        if (!_cmp.checkAll() || !editform.check() ) return;//先校验
        if (!_cmp.saveCheck()) return;
        //保存之前存放当前最后一次||
        if (_curtab == "total" || _curtab == "year" ) {
            var tempdata =  datatable.getAllData();
            tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
            var goaldata =  editform.getEditFormValues();
            tabcomps["#goal"+_curtab] =Ext.lt.cloneobj(goaldata);
        }
        //判断总体绩效的是否存在
        var tempgoal =  tabcomps["#goaltotal"];
        if(tempgoal["kpi_target"] == "" || !tempgoal["kpi_target"]){
            alert("调整调剂缺少项目总体绩效数据不能保存，请检查项目库是否填报总体绩效！");
            return;
        }
        //判断年度绩效是否存在
        var tempgoal =  tabcomps["#goalyear"];
        if(tempgoal["kpi_target"] == "" || !tempgoal["kpi_target"]){//如果调整前目标不存在 调整后目标必填
            if(tempgoal["adjustndgoal"] == "" || !tempgoal["adjustndgoal"]){
                alert("请填写调整后年度绩效目标或在年度绩效页签中点击复制总体绩效！");
                return;
            }
        }
        //年度绩效指标名称重复校验
        var repetMsg =_cmp.getRepetitionMsg(tabcomps["#year"]);
        if(repetMsg){
            alert("年度绩效 '"+repetMsg+"' 指标名称重复，无法保存！");
            return;
        }
        var params = {};
        params.projguid = _proguid;
        params.procode = _procode;
        params.adjmainguid = _adjmainguid;
        params.datas = tabcomps;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.procat = procat; //类别
        params.prolev = _prolev;//项目级别 123
        params.showtab = showtab; //展示的目标数
        params.isedittotal = _isedittotal; //是否可编辑
        params.isbefore = _isbefore;
        params.reporttype = _reporttype;
        var rs = Ext.lt.RCP.asyncall(serviceid , "savePrjTreeIndex", params);
        if(rs && rs.success){
            alert("保存成功！");
            _cmp.init();
        } else if (rs && rs.success == false){
            // tabpage.doActiveTab(0);
            openlistdiv(rs);
        }
        return rs;
    }

    /**
     * 验证重复指标名
     */
    _cmp.getRepetitionMsg = function(Array){
        var wordMap = new Map();
        var repetitionObjs = [];
        Array.forEach(obj => {
            if (obj.name!="" && obj.levelno==3 && obj.status!="1" && wordMap.has(obj.name.trim())){
                repetitionObjs.push(obj);
                var matchedWord = wordMap.get(obj.name.trim());
                repetitionObjs.push(matchedWord);
            } else if(obj.name!="" && obj.levelno==3  && obj.status!="1"){
                wordMap.set(obj.name.trim(), obj);
            }
        })
        repetitionObjs.sort((a, b) => {
            return (a.name.trim() + a.code) > (b.name.trim() + b.code)  ? 1 : -1;
        })
        for (var i = 0; i < repetitionObjs.length - 1; i++) {
            if (repetitionObjs[i].name.trim() === repetitionObjs[i + 1].name.trim() ) {
                repetitionObjs.splice(i,1);
                i = i - 1;
            }
        }
        var returnMsg = "";
        repetitionObjs.forEach(item => {returnMsg+= item.name.trim() + "、";})
        returnMsg = returnMsg.slice(0,returnMsg.length-1);
        return returnMsg;
    }


    /**
     * 填报绩效可编辑页面.
     */
    addperformance = function(){
        var httpurl = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ":" + window.location.port : "");
       var url = httpurl+ Ext.lt.token.urlAddToken('/pmkpi/program/report/bgtindex.page?state='+_state+
           "&ProCat="+procat+"&setyear="+_setyear+"&admdiv="+_admdiv+"&ISXZZD="+_ISXZZD+"&itemid="+_proguid+"&usercode="+_usercode
           +"&showtab="+showtab+"&isbefore="+_isbefore+"&isedittotal="+_isedittotal+"&noreadonly=1")+ Ext.lt.token.getAuthorization();
        $windowObj=window.open(url,"_blank");
    }
    /**
     * 精准推荐方法.
     */
    _cmp.recom = function(){
        var url = '/pmkpi/program/prjindex/recomindex.page';
        var params = {};
        params.proguid = _proguid;
        params.procode = _procode;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        params.isadjust = "true";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,_scrWidth * 0.98,_scrHeight * 0.98,"指标推荐");
    }

    /**
     *  新增行
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
        indexdata.status = 3;
        indexdata.obligate1 = "删除";
        if (_curtab == "total") {
            indexdata.yearflag = "1";
        } else if (_curtab == "year") {
            indexdata.yearflag = "0";
        }
        doMapper(_pmkpidatatype, datatable.getCol(3));
        datatable.getRecordSet().addData(indexdata,_sortid + datatable.getRecordset().toArray().length);
    }

    /**
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        if (obj.table.config.id == "datatable"){
            for(var i=0; i<cols.length; i++){
                var col = cols[i];
                if (_viewtype == 'query' && col["name"] != "check") {
                    col.style = "background-color:#f2f2f2;";
                    col.oneditstart = function (table, e, l, c, d) {
                        return false;
                    }
                }
                if (col["colcode"] == "obligate1") {
                    if (_viewtype != "query") {
                        col.style = " text-align:center;color:#468ac9;cursor:pointer;";
                        col.onclick = function (td, el, l, c, d) {
                            var levelno = d.levelno;
                            if (levelno == "2") {
                                _cmp.addrow( d.guid);
                                // cmp.add("", d.guid);
                            } else if (levelno == "3" && d.status != "1") {
                                if(d.code == '149999' || d.name == '项目或定额成本控制率'){
                                }else {
                                    _cmp.del("", d.guid);
                                }
                            } else if (d.levelno == "3" && d.status == "1") {
                                Ext.lt.ui.confirm("确认要撤销删除选中指标？", {icon: "warn"}, function (ret) {
                                    if (ret) {
                                        var _sortid = d._sortid;
                                        d.status = "";
                                        d.obligate1 = "删除";
                                        d.adjustindexval = "";
                                        $.extend(d, d); //合并值集刷新
                                        datatable.reflash(_sortid);
                                    }
                                })
                            }
                        };
                    }
                }
                if(col["colcode"]=="indexval" || col["colcode"]=="computesign" || col["colcode"]=="name"
                    || col["colcode"]=="meterunit" || col["colcode"]=="kpi_value" || col["colcode"]=="kpi_remark"){
                    col.oneditstart = function (table, el, l, c, d) {
                        if (d.levelno != "3" || d.status != "3") {
                            return false;
                        }
                        if(d.code == '149999' || d.name == '项目或定额成本控制率'){
                            return false;
                        }
                    }
                }
                if(col["colcode"]=="indexval"){
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
                        if (d.levelno != "3" || d.status != "3") {
                            return false;
                        }
                        if(d.code == '149999' || d.name == '项目或定额成本控制率'){
                            return false;
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

                if (col["colcode"] == "adjustindexval") {
                    col.fn = function (l, c, data, col) {
                        if (data.computesign == "6" || data.computesign == "9" || data.computesign == "10"  || ismergeindex != "1") {
                            var indexvalue = !data.adjustindexval ? "" : data.adjustindexval;
                            return "<font style=\"margin-left:10px;\">" + indexvalue + "</font>";
                        } else {
                            var computesignstr = "";
                            for (var i = 0; i < _signs.size(); i++) {
                                if (data.computesign == _signs[i].guid) {
                                    computesignstr = _signs[i].name;
                                }
                            }
                            var unit = "";
                            if (data["meterunit"]) {
                                unit = data.meterunit;
                            }
                            var returnstr = !data.adjustindexval ? computesignstr + unit : computesignstr + data.adjustindexval + unit;
                            return "<font style=\"margin-left:10px;\">" + returnstr + "</font>";
                        }
                    }
                    col.oneditstart = function (table, el, l, c, d) {
                        if (d.levelno != "3" || (d.status && d.status != "2")) {
                            return false;
                        }
                        if (d.computesign == "9") { //合肥添加定量其他
                            doMapper(_kpivals, table.getCol(c));
                            this.config.isMulti = false;
                            return;
                        }else if(d.computesign == "10"){
                            doMapper(_kpicalnotapply,table.getCol(c));
                            this.config.isMulti = false;
                            return;
                        } else {
                            el.innerText = d.adjustindexval != undefined ? d.adjustindexval : '';
                            table.getCol(c).mapping = null;
                            table.nowtype = "input";
                            table.getCol(c).format = "";
                        }
                        //河北的固化指标不可修改
                        if(d.code == '149999' || d.name == '项目或定额成本控制率'){
                            return false;
                        }
                        // return;
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        var computesign = d.computesign;
                        if (computesign && computesign != '6' && computesign != '9' && computesign != '10') {
                            if (!checkReferencepole(d.adjustindexval)) {
                                d.adjustindexval = '';
                                return false;
                            }
                        }
                        if (d.adjustindexval != '') {
                            if (!computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！", {timeout: 1}, function () {
                                });
                                d.adjustindexval = '';
                                return false;
                            }
                        }
                        if (computesign == "9") {
                            d["kpivalsource"] = d["adjustindexval"];
                        }
                        if (!d.status && d.status != 3) {
                            d.status = 2;
                            doMapper(_pmkpidatatype, table.getCol(3));
                        }
                        if (d.status != 3 && !d["adjustindexval"]) {
                            d.status = "";
                        }
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
                                return false;
                            }
                        }
                    }
                }
            }
        }
    })

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

    //导出
    _cmp.export = function() {
        exportIndexFile();

    }

    exportIndexFile = function () {
        var idObject = document.getElementById("downloadfileform");
        if (idObject != null){
            idObject.parentNode.removeChild(idObject);
        }
        var url = "/pmkpi/export/hbftl.do?tokenid=" + Ext.lt.token.getTokenid();
        var form=$("<form>");//定义一个form表单
        form.attr("id","downloadfileform");
        form.attr("style","display:none");
        form.attr("target","");
        form.attr("method","post"); //请求类型
        form.attr("action",url); //请求地址
        $("body").append(form);//将表单放置在web中

        var guids = [];
        guids.push(_adjmainguid);
        var input1=$("<input>");
        input1.attr("type","hidden");
        input1.attr("id","guids");
        input1.attr("name","guids");
        input1.attr("value",guids);
        form.append(input1);

        var _templatecode;
        if(_curtab == "total"){
            _templatecode = "progoalandindex";
        }else if(_curtab == "year") {
            _templatecode = "hbproadjyeargoalandindex";
        }
        var input2=$("<input>");
        input2.attr("type","hidden");
        input2.attr("id","templatecode");
        input2.attr("name","templatecode");
        input2.attr("value",_templatecode);
        form.append(input2);

        var bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        var input3=$("<input>");
        input3.attr("type","hidden");
        input3.attr("id","bobeanid");
        input3.attr("name","bobeanid");
        input3.attr("value",bobeanid);
        form.append(input3);
        form.submit();
    }

    return _cmp;


}

function getdataSource() {
    var datatype_source = [];
    for (var i = 0; i < _datatype.length; i++) {
        var temparr = [];
        temparr.push(_datatype[i]["guid"]);
        temparr.push(_datatype[i]["code"]);
        temparr.push(_datatype[i]["name"]);
        datatype_source.push(temparr);
    }
    datatable.addMapperDatas("status", datatype_source);
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


function getPointNum(num){
    var str = String(num);
    var index = str.split(".");
    var str1 = null;
    if(index.length == 2){
        str1 = index[1].substring(0,2);
        str1 = Number(index[0]+"."+str1);
    } else {
        str1 = Number(index[0]);
    }
    return str1;
}

/**
 * 审核定义弹窗
 * @param rt
 */
function openlistdiv(rt){
    var rtdata = rt.redata;
    var dicv=document.createElement('div')
    dicv.innerHTML='<div id="errdiv" style="height: '+(_scrHeight-250)+'px;overflow: hidden">' +
        '<div id="errordata" style="height: '+(_scrHeight-200)+'px;overflow: hidden"></div></div>';
    dicv.style.height=_scrHeight;
    dicv.style.width=_scrWidth;
    if(listdiv == null){
        listdiv=new Ext.lt.window({title:"错误信息", w:_scrWidth-380, h:_scrHeight-300,close:true,pop:true,mark:true,className:'windpop'});
    }
    listdiv.draw(dicv);
    detaildatas = new Ext.lt.recordset();
    dtable = new Ext.lt.datatable(detaildatas);
    var columns = [
        {name:'code',alias:'审核定义编码',datatype:'s',columncode:'code'},
        {name:'name',alias:'审核定义名称',datatype:'s',columncode:'name'},
        {name:'remark',alias:'错误信息',datatype:'s',columncode:'remark'},
        {name:'explain',alias:'审核说明',datatype:'s',columncode:'explain'}
    ];
    dtable.setCols(columns);
    dtable.setMouselight('#FCE0AE');
    dtable.mousedrag(false);
    dtable.setClassName('dttheme_ifmis');
    var errordiv = document.getElementById('errordata');
    errordiv.style.height = _scrHeight;
    dtable.draw(errordiv);
    detaildatas.setData(rtdata);
    listdiv.show();
}

$windowObj  = null;
var loop = setInterval(function() {
    if($windowObj  != null && $windowObj.closed) {
        clearInterval(loop);
        //do something 在这里执行回调
        mergeindex.init();
    }
}, 800);