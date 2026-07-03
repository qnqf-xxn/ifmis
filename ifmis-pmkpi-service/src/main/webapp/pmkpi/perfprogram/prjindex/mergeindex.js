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
var ischeckbefore = false;
var _scrWidth =document.body.clientWidth,
    _scrHeight =document.body.clientHeight;
Ext.lt.pmkpi.treeindex = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
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
    var _cmp = {};
    tabcomps = config["indexdata"]; //总体的指标数据.
    tabcomps["del#total"] = []; //总体删除
    tabcomps["del#year"] = []; //年度删除
    showtab = config.showtab; //页签展示

    var hideIframeHtml = "";
    height = $(window).height()*0.9;
    width = $(window).width()*0.9;
    var _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _prjindexcoldatas = config["prjindexcoldatas"];//表格列
    var tabnum = 0; //页签点击次数
    var _state = config.state;//贵州 1新增2修改，3查看
    //页面加载完成后执行
    $(function() {
        if(_curtab == "total"){
            $('textarea[name="kpi_target"]').attr("placeholder","概述：描述中长期预期效果\n" +
                "目标1：描述中长期预期产出1\n" +
                "目标2：描述中长期预期产出2\n");
        }else {
            $('textarea[name="kpi_target"]').attr("placeholder","概述：描述年度预期效果\n" +
                "目标1：描述年度预期产出1\n" +
                "目标2：描述年度预期产出2\n");
        }
        var tempdata = tabcomps["#"+_curtab]; //绩效指标
        datatable.setDatas(tempdata);
        var goaldata = tabcomps["#goal"+_curtab];//绩效目标
        editform.synchEditformByObj(goaldata);
        if (_isedittotal == "1" && _curtab == "total") {
            editform.setdisabled({kpi_target:true});
        } else {
            editform.setdisabled({kpi_target:false});
        }
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
            if (_state != "3" && !_noreadonly){
                $('.layui-tab-title').append("<button title='填报绩效' onclick=\"addperformance();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">填报绩效</button>");
            }
            if(_noreadonly =="1" && (procat == "1" || procat=="3")){
                $('.layui-tab-title').append("<button title='保存' onclick=\"savealltab();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">保存</button>");
            }
            if (_state == "3"){
                $('.layui-tab-title').append("<button id='exportindex' title='导出指标' onclick=\"exportIndexFile();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\"></button>");
                /*$('.layui-tab-title').append("<button id='exportyearindex' title='导出年度指标' onclick=\"exportIndexFile();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">导出年度指标</button>");*/
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
            for(var i = 2; i<befortable.getCols().length; i++){
                befortable.getCols()[i].edit = false;
            }
            datatable.redraw();
            befortable.redraw();
        } else {
            $('.layui-tab-title').append("<button title='保存' onclick=\"savealltab();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">保存</button>");
        }
    });

    /**
     * 点击页签.
     */
    _cmp.clickTabpage = function(obj){
        if(obj.code == "year"){
            var idObject = document.getElementById("copytotalindex");
            if (idObject == null){
                $('.layui-tab-title').append("<button id='copytotalindex' title='复制总体绩效' onclick=\"Ext.lt.pmkpi.copytotalindex();\" type=\"button\" style=\"float:left;margin:0 10px 0 15px;background-color:#3472ef\" class=\"layui-btn btn-black\">复制总体绩效</button>");
            }
        }
        if(obj.code == "total"){
            $('textarea[name="kpi_target"]').attr("placeholder","概述：描述中长期预期效果\n" +
                "目标1：描述中长期预期产出1\n" +
                "目标2：描述中长期预期产出2\n");
        }else {
            $('textarea[name="kpi_target"]').attr("placeholder","概述：描述年度预期效果\n" +
                "目标1：描述年度预期产出1\n" +
                "目标2：描述年度预期产出2\n");
        }
        if(showtab == "1" && obj.code == "year"){
            if ($("div[compid='toolbutton']")){
                $("div[compid='toolbutton']").show();
            }
        }
        if (_state == "3"){
            if(obj.code == "total"){
                $("#exportindex").text("导出总体指标");
            }else if(obj.code == "year") {
                $("#exportindex").text("导出年度指标");
            }else {
                $("#exportindex").hide();
            }
        }
        if(obj.code == "year" && _noreadonly =="1" && (procat == "1" || procat=="3")){
            $("#copytotalindex").show();
        }else {
            $("#copytotalindex").hide();
        }
        if (obj.code == "before"){ //事前评估
            var contweight = $("#datatable").width();
            var contheight = $("#toolbutton").height() + $("#editform").height() + $("#datatable").height() + 11;
            if (document.getElementById("editform")){
                document.getElementById("editform").style.display = "none";
            }
            if (document.getElementById("datatable")){
                document.getElementById("datatable").style.display = "none";
            }
            if ($("div[compid='toolbutton']")){
                $("div[compid='toolbutton']").hide();
            }
            if (document.getElementById("befortable")){
                document.getElementById("befortable").style.display = "block";
                befortable.resize(contweight,contheight);
            }
        } else {
            /*if (_isedittotal == "1" && obj.code == "total") {
                document.getElementById("toolbutton").style.display = "none";
            }*/
            if (document.getElementById("befortable")){
                document.getElementById("befortable").style.display = "none";
            }
            if (document.getElementById("editform")){
                document.getElementById("editform").style.display = "block";
            }
            if (document.getElementById("datatable")){
                document.getElementById("datatable").style.display = "block";
                //datatable.resize($("#datatable").width(),$("#datatable").height());
            }
            if ($("div[compid='toolbutton']")){
                $("div[compid='toolbutton']").show();
            }
            if(showtab == "1" && obj.code == "total"){
                /*if (document.getElementById("toolbutton")){
                    document.getElementById("toolbutton").style.display = "none";
                }*/
                var tabconfig = eval('(' + obj.config + ')');
                var hideBtn = tabconfig.hidebtn;
                if(hideBtn != undefined && hideBtn != ""){
                    var hideBtnArr = hideBtn.split(",");
                    toolbutton.hidden(hideBtnArr);
                }
            }else {
                common.changTooltoolbuttontStatus(0,obj.hidebtns);
            }
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
            } else if ( _curtab != obj.code && _curtab == "before"){ //事前评估校验
                var beforetabledata =befortable.getRecordSet().toArray();
                for(var i = 0; i<beforetabledata.length; i++){
                    var score = beforetabledata[i].unit_since_score;
                    if(score!=null && score != undefined && score != ""){
                        ischeckbefore = true;
                        break;
                    }
                }
                if (ischeckbefore && !befortable.checkAll()) {
                    var tempdata =  befortable.getRecordSet().toArray();
                    if (tempdata.length > 0){
                        tabcomps["#before"] =Ext.lt.cloneobj(tempdata);
                    }
                    tabpage.doActiveTab(2);
                    return;//先校验
                }
                var tempdata =  befortable.getRecordSet().toArray();
                if (tempdata.length > 0){
                    tabcomps["#before"] =Ext.lt.cloneobj(tempdata);
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
            if (_isedittotal == "1" && obj.code == "total") {
                editform.setdisabled({kpi_target:true});
            } else {
                editform.setdisabled({kpi_target:false});
            }
        } else if(obj.code == "before"){
            var tempdata = tabcomps["#"+obj.code];
            befortable.setDatas(tempdata);
            setTimeout(function(){
                beforeamtTotal(befortable);
            },300);
        }
        if (_viewtype == "query" && tabnum != 0) {
            $("div[compid='toolbutton']").hide();
            editform.setdisabled({kpi_target:true});
        }
        _curtab = obj.code;
        tabnum ++;
        Ext.lt.message.send("datatable", 'beforesetcols', {
            table: datatable,
            cols: _prjindexcoldatas
        });
        setTimeout(function(){
            changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns); //隐藏按钮
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
        },120);
    }

    /**
     * 复制总体指标
     */
    Ext.lt.pmkpi.copytotalindex = function(){
        var data;
        if (_curtab == "total") {
            if(procat == "1" || procat=="3"){
                Ext.lt.ui.alert("请点击年度绩效页签再复制！",function(){});
                return;
            }
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
                    //处理绩效目标
                    var goaldata = tabcomps["#goaltotal"];//绩效目标
                    var tempgoal = editform.getEditFormValues(); //年度有值覆盖
                    if(tempgoal["kpi_target"] && tempgoal["kpi_target"] != "" && (procat == "1" || procat=="3")){
                        alert("年度绩效已经存在不能重复点击复制总体按钮！");
                        return;
                    }
                    tempgoal.kpi_target = goaldata.kpi_target;
                    editform.synchEditformByObj(tempgoal);
                    var yeargoaltemp = editform.getEditFormValues(); //年度有值覆盖
                    tabcomps["#goalyear"] =Ext.lt.cloneobj(yeargoaltemp);
                    //end;
                    setYeardata(data);
                }
            })
        }
    }

    function setYeardata(data){
        var yeardatas = Ext.lt.cloneobj(data);
        for (var i=0; i<yeardatas.length; i++) {
            if (yeardatas[i]["name"] =="项目或定额成本控制率" && (procat =="4" || procat == "5")){
                continue;
            }
            if (yeardatas[i].levelno == 3) {
                var params = {};
                for (var key in yeardatas[i]) {
                    params[key] =  yeardatas[i][key];
                }
                params.rowtype = "add";
                params['guid'] = getCreateguid(serviceid);
                //只有复制总体到年度，修改busi_type_code
                params["busi_type_code"] = "2";
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

    /**
     * 页面初始化.
     */
    _cmp.init = function(){
        var params = {};
        params.proguid = _proguid;
        params.showtab = showtab;
        params.isbefore = _isbefore;
        params.procat = procat;
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
                setTimeout(function(){
                    amtTotal(datatable);
                },100);
            } else if (_curtab == "before"){
                var tempdata = tabcomps["#"+_curtab];
                befortable.setDatas(tempdata);
                setTimeout(function(){
                    beforeamtTotal(befortable);
                },100);
            }
            //Ext.lt.ui.loadingClose();
        })
    }

    /**
     * 新增
     */
    _cmp.add = function(obj,selguid){
        _cmp.addIndexRow(obj,selguid);
        /*var data = [];
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
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"新增指标");*/
    }

    /**
     * 行内新增
     */
    _cmp.addIndexRow = function(obj,selguid){
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
        var _fromtype = "tree";
        var parent_sel_rows = datatable.getRecordset().query({guid:data[0].guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        if (parent_sel_obj["levelno"] == 2 && "tree" == _fromtype) {
            parent_sel_obj["check"] = null;
            parent_sel_obj["isleaf"] = 0;
            parent_sel_obj["_isleaf"] = 0;
            datatable.reflash(_sortid);
        }

        var newdata = {};
        newdata.levelno = 3;
        newdata.isleaf = 1;
        newdata._isleaf = 1;
        newdata.rowtype = "add";
        newdata["guid"] = getCreateguid(serviceid);
        newdata["findex"] = parent_sel_obj["findex"];
        newdata["sindex"] = parent_sel_obj["sindex"];
        newdata.superid = parent_sel_obj["sindex"];
        datatable.getRecordSet().addData(newdata,_sortid + datatable.getRecordset().toArray().length);
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
        if(data[0].code == '149999' || data[0].name == '项目或定额成本控制率'){
            Ext.lt.ui.alert("此条三级指标不可修改！",function(){});
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
					//删除同步处理tabcomps数据集合（不处理会影响复制功能）
                    var tempdata =  datatable.getAllData();
                    tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
                }
            }
        })
    }
    /**
     * 保存方法.
     */
    _cmp.save = function(obj){
        if (!_cmp.checkAll() || !editform.check() ) return;//先校验
        if (ischeckbefore){ //校验事前
            if (!befortable.checkAll()) {
                return;
            };
        }
        var repetMsg =_cmp.getRepetitionMsg(datatable.getRecordSet().toArray());
        if(repetMsg){
            alert("'"+repetMsg+"' 指标名称重复，无法保存！");
            return;
        }
        //保存之前存放当前最后一次||
        if (_curtab == "total" || _curtab == "year" ) {
            var tempdata =  datatable.getAllData();
            tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
            var goaldata =  editform.getEditFormValues();
            tabcomps["#goal"+_curtab] =Ext.lt.cloneobj(goaldata);
        } else if (_curtab == "before") {
            var tempdata =  befortable.getRecordSet().toArray();
            if (tempdata.length > 0){
                tabcomps["#before"] =Ext.lt.cloneobj(tempdata);
            }
        }
        var params = {};
        params.projguid = _proguid;
        params.datas = tabcomps;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.prolev = _prolev;//项目级别 123
        params.showtab = showtab; //展示的目标数
        params.isedittotal = _isedittotal; //是否可编辑
        params.isbefore = _isbefore;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "savePrjTreeIndex", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            _cmp.init();
        }
        return rs;
    }
    /**
     * 页面自己单独的保存.var ischeckbefore = false;
     */
    savealltab = function(){
        if (!_cmp.checkAll() || !editform.check() ) return;//先校验
        if (ischeckbefore){ //校验事前
            if (!befortable.checkAll()) {
                return;
            };
        }
        //保存之前存放当前最后一次||
        if (_curtab == "total" || _curtab == "year" ) {
            var tempdata =  datatable.getAllData();
            tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
            var goaldata =  editform.getEditFormValues();
            tabcomps["#goal"+_curtab] =Ext.lt.cloneobj(goaldata);
            //判断总体绩效的是否存在
            //var tempgoal =  tabcomps["#goaltotal"];
            //if(tempgoal["kpi_target"] == "" || !tempgoal["kpi_target"]){
            //    alert("请填写总体绩效目标！");
            //    return;
            //}
        } else if (_curtab == "before") {
            var tempdata =  befortable.getRecordSet().toArray();
            if (tempdata.length > 0){
                tabcomps["#before"] =Ext.lt.cloneobj(tempdata);
            }
        }
        //多页签，判断年度的是否存在
        if (showtab == "1"){
            var tempgoal =  tabcomps["#goalyear"];
            if(tempgoal["kpi_target"] == "" || !tempgoal["kpi_target"]){
                alert("请填写年度绩效目标或在年度绩效页签中点击复制总体绩效！");
                return;
            }
            if(_isedittotal == "1"){//总+年 总体不可编辑时，只校验年度指标名称重复
                var repetMsg =_cmp.getRepetitionMsg(tabcomps["#year"]);
                if(repetMsg){
                    alert("年度指标 '"+repetMsg+"' 指标名称重复，无法保存！");
                    return;
                }
            }else{//否则都校验
                var repetMsg =_cmp.getRepetitionMsg(tabcomps["#year"]);
                if(repetMsg){
                    alert("年度指标 '"+repetMsg+"' 指标名称重复，无法保存！");
                    return;
                }
                var repetMsg =_cmp.getRepetitionMsg(tabcomps["#total"]);
                if(repetMsg){
                    alert("总体指标 '"+repetMsg+"' 指标名称重复，无法保存！");
                    return;
                }
            }
        }else{//总 校验总体指标名称重复
            var repetMsg =_cmp.getRepetitionMsg(tabcomps["#total"]);
            if(repetMsg){
                alert("总体指标 '"+repetMsg+"' 指标名称重复，无法保存！");
                return;
            }
        }
        var params = {};
        params.projguid = _proguid;
        params.datas = tabcomps;
        params.saveAgency = _saveAgency;
        params.busguid = _busguid;
        params.procat = procat; //类别
        params.prolev = _prolev;//项目级别 123
        params.showtab = showtab; //展示的目标数
        params.isedittotal = _isedittotal; //是否可编辑
        params.isbefore = _isbefore;
        var rs = Ext.lt.RCP.asyncall(serviceid , "savePrjTreeIndex", params);
        if(rs && rs.success){
            alert("保存成功！");
            _cmp.init();
        } else if (rs && rs.success == false){
            tabpage.doActiveTab(0);
            openlistdiv(rs);
        }
    }

    /**
     * 验证重复指标名
     */
    _cmp.getRepetitionMsg = function(Array){
        var wordMap = new Map();
        var repetitionObjs = [];
        Array.forEach(obj => {
            if (obj.name!="" && obj.levelno==3 && wordMap.has(obj.name.trim())){
                repetitionObjs.push(obj);
                var matchedWord = wordMap.get(obj.name.trim());
                repetitionObjs.push(matchedWord);
            } else if(obj.name!="" && obj.levelno==3){
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
       var url = httpurl+ Ext.lt.token.urlAddToken('/pmkpi/program/report/mergeindex.page?state='+_state+
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
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,_scrWidth * 0.98,_scrHeight * 0.98,"指标推荐");
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
        if (obj.table.config.id == "datatable"){
            for(var i=0; i<cols.length; i++){
                var col = cols[i];
                if(col["colcode"]=="indexval" || col["colcode"]=="computesign" || col["colcode"]=="name"
                    || col["colcode"]=="meterunit" || col["colcode"]=="kpi_value" || col["colcode"]=="kpi_remark"){
                    col.oneditstart = function (table, el, l, c, d) {
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
                        if(d.levelno != "3"){
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
                //一二级指标不可修改
                if(col["colcode"]!="indexval"){
                    col.oneditstart = function(table,el,l,c,d){
                        if (_isedittotal == "1" && _curtab == "total") {
                            return false;
                        }
                        if(d.levelno != "3"){
                            return false;
                        }
                        if(d.code == '149999' || d.name == '项目或定额成本控制率'){
                            return false;
                        }
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.levelno == "3" && d.rowtype!="add"){
                            d.rowtype ="mod";
                        }
                    }
                }
                if(col["colcode"]=="obligate1"){
                    if (_viewtype != "query"){
                        col.style = " text-align:center;";
                        col.fn = function(l,c,data,col){
                            var html = "";
                            if(data.levelno == "2"){
                                // html += '<a title = "选择" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexcheck("'+data.guid+'")\'>选择</a>';
                                // html += '&nbsp;&nbsp;&nbsp;&nbsp';
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:mergeindex.add("","'+data.guid+'")\'>新增</a>';
                            } else if(data.levelno == "3" && data.name != "项目或定额成本控制率"){
                                //贵州特殊,特定目标类项目，指标‘项目或定额成本控制率’不能删除
                                html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:mergeindex.del("","'+data.guid+'")\'>删除</a>';
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
        } else if (obj.table.config.id == "befortable") {
            for(var i=0; i<cols.length; i++){
                var col = cols[i];
                if(col["colcode"] == "adv_eva_info"){
                    var findex = "";
                    var subfindex = "";
                    col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                        if(j==2){
                            var tabledata = befortable.getRecordSet().toArray();
                            var statnum = 0;
                            if(i==statnum){
                                findex = Ext.lt.cloneobj(rs["adv_eva_info"]);
                            }
                            if(findex == rs["adv_eva_info"]){
                                style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
                            } else {
                                style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
                            }
                            findex = Ext.lt.cloneobj(rs["adv_eva_info"]);
                            if(i == tabledata.length-1){
                                style =style +'border-bottom-style:solid;"';
                            } else {
                                style =style + '"';
                            }
                            if(befortable.uiconfig.totaltag ==1 && i==0){ //有权重的合计
                                style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;"';
                            }
                        }
                        return style;
                    }
                    col.fn = function(i,c,rs,value){ //行的显示样式.
                        if(rs["adv_eva_info"]){
                            subfindex = Ext.lt.cloneobj(rs["adv_eva_info"]);
                            var seq = showMidleName(subfindex,"adv_eva_info");
                            if(i==seq){
                                return value;
                            }
                            return "";
                        }
                    }
                }

                if(col["colcode"]=="option_value"){
                    col.fn = function(l,c,data,col){
                        var yrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_y'+data.ordernum+'" name="option_value_radio'+data.ordernum+'" value="1">是';
                        var yrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_y'+data.ordernum+'" checked="checked" name="option_value_radio'+data.ordernum+'" value="1">是';
                        var nrs = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_n'+data.ordernum+'" name="option_value_radio'+data.ordernum+'" value="0">否';
                        var nrsc = '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="radio" id="option_value_n'+data.ordernum+'" checked="checked" name="option_value_radio'+data.ordernum+'" value="0">否';
                        if(data.datatable_do_sum==true){
                            return "";
                        }else if(data.option_value == '1'){
                            return yrsc + nrs;
                        }else if(data.option_value == '0'){
                            return yrs + nrsc;
                        }else{
                            return yrs + nrs;
                        }
                    }

                    col.onclick = function (table, el, l, c, d) {
                        var option_value = $("input[name='option_value_radio"+d.ordernum+"']:checked").val();
                        if(option_value == '1'){
                            d.option_value = '1';
                            d.unit_since_score = d.weight;
                        }else{
                            d.option_value = '0';
                            d.unit_since_score = '0';
                        }
                        beforeamtTotal(table);
                    }
                }

            }
        }


    })

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
     * 复选框操作.
     * {
        table: table,
        datas: table.getCheckRecordSet().query({
            check: 1
        })
     */
    /*Ext.lt.message.hook("fasp2datatable", "chkClick", function (obj) {
            debugger;
    });*/
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
                if(datas[i].name.length > 100){
                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的指标名称不能大于100个字！",{timeout:1},function(){});
                    return;
                }
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
        guids.push(_proguid);
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
            _templatecode = "hbproyeargoalandindex";
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
showMidleName = function(val,col){
    var tabledata = befortable.getRecordSet().toArray();
    var a = -1,b=-1;
    var atemp = {};
    for ( var i = 0; i < tabledata.length; i++) {
        atemp = tabledata[i];
        if(val == atemp[col]){
            a = atemp["_sortid"]; //首次出现值
            break;
        }
    }
    var btemp = {};
    for ( var i = tabledata.length-1; i >-1; i--) {
        btemp = tabledata[i];
        if(val == btemp[col]){
            b = btemp["_sortid"]; //结束出现值
            break;
        }
    }
    return parseInt((b-a)/2)+a;
}

function beforeamtTotal(table) {
    if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var sumweight = 0;
        var sumscore = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
            sumweight += parseFloat(weight);
            var unit_since_score = rowarr[i]["unit_since_score"] ? rowarr[i]["unit_since_score"] : 0;
            sumscore += parseFloat(unit_since_score);
        }
        var totalrs = {};
        totalrs["weight"] = sumweight == 0 ? "" : getPointNum(sumweight);
        totalrs["unit_since_score"] = sumscore == 0 ? 0 : getPointNum(sumscore);
        totalrs.datatable_do_sum=true;
        totalrs["evaluate_problem"]="项目总得分>=90 优; 80<=项目总得分<=89 良; 60<=项目总得分<=79 中; 项目总得分<60 差";
        table.getClockRowSet().setData(totalrs,0);
        if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        }
        //处理等级
        var levtitle = "";
        var levsorce = getPointNum(sumscore);
        if (levsorce >= 90){
            levtitle = "等级：优";
        } else if (levsorce >= 80 && levsorce <= 89 ){
            levtitle = "等级：良";
        } else if (levsorce >= 60 && levsorce <= 79 ){
            levtitle = "等级：中";
        } else {
            levtitle = "等级：差";
        }
        $("div#befortable div.titlename ").html(levtitle);
    }
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