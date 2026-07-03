if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
var _curtab;
var tabcomps;
var showtab;
var _isedittotal;
var _procode;
var goalguid;
var indexdeldatas = {};
var totalgoals = []; //总体目标
var yeargoals = []; //年度目标
var deltotal =[]; //删除的总体目标
var delyear = []; //删除的年度目标
Ext.lt.pmkpi.goalandindexservice = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _proguid = config["proguid"];
    var _pro_code = config["pro_code"];
    var _viewtype = config["viewtype"]; //修改还是查看
    var _showall = config["showall"]; ////项目库可以跨地区查询项目基本信息
    var _dataprovince = config["dataprovince"]; //区划
    var _saveAgency = config["saveAgency"]; //项目单位
    _isedittotal = config["isedittotal"]; //总体指标是否可编辑
    var _busguid = config.busguid;//审核定义guid
    var selectbillguid = config.selectbillguid;//调整前的guid
    var adjadd = config.adjadd;//是否调整
    var isnzzj = config.isnzzj;//是否年中追加
    var frametype = config.frametype;//层次分了类型
    var _prolev = config["prolev"]; //项目等级123级项目
    var totalgoalname = config.totalname;//项目页签（编辑区）名称
    var _signs = config["signs"];//指标符号
    var standards = config["standards"];//绩效标准
    var _kpivals = config["kpivals"]; //合肥定量其他值.
    var _kpicalnotapply = config["kpicalnotapply"];//不适用
    _procode = config.procode;
    showtab = config.showtab; //页签展示
    var tempcode = config.tempcode;//内置模板编码
    var pdmsave = config.pdmsave;//暂存方法.
    var tabnum = 0; //页签点击次数
    var cmp = {};
    indexdeldatas["del#total"] = []; //总体删除(指标)
    indexdeldatas["del#year"] = []; //年度删除(指标)
    var iframeurl = config.iframeurl;//嵌套url
    var ismergeindex = config["ismergeindex"];//指标值是否合并单位符号
    //var aa = config["indexdata"];
    var tabname = "";
    var hideIframeHtml = "";
    height = document.documentElement.clientHeight * 0.9;
    width = document.documentElement.clientWidth * 0.9;
    if (height < 450) {
        height = 450;
    }
    if (width < 800) {
        width = 1000;
    }
    if (iframeurl && iframeurl != "") {
        var url = document.location.protocol+"//" + document.location.host + "/" + iframeurl;
        url = Ext.lt.pmkpi.genPageUrl(url, null);
        hideIframeHtml = "<iframe scrolling='no' frameborder=0 style='display: none' src =' " + url + " '></iframe>";
    }
    var isFirst = true;
    var isfirsttab;
    var _displaycols = [];
    var _goaldisplaycols = [];
    var firstpage = true;
    var _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    var _nulltempindexs;
    var _selgoalguid;



    /**
     * 页面加载完成后立即执行
     */
    $(function () {
        Ext.lt.message.send("datatable", 'beforesetcols', {
            table: goaldatatable,
            cols: goaldatatable.getCols()
        });
        common.initDatatable();
        cmp.bulidTopHead();
        if(hideIframeHtml != null && hideIframeHtml != ""){
            $("#goaldatatable").append(hideIframeHtml);
        }
        if (_viewtype == "query") {
            for(var i=2; i<goaldatatable.getCols().length; i++){
                goaldatatable.getCols()[i].edit = false;
            }
            for(var i=2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            goaldatatable.redraw();
            datatable.redraw();
        }
        common.changTooltoolbuttontStatus(0,['查看评审意见','复制上年指标']);
        if (_viewtype == "query" || (_isedittotal == "1" && _curtab == "total")) {
            $("div[compid='toolbutton']").hide();
            if(_SYSTEMSTYLE_ == "grey"){
                $(".tbtitle").hide();
            }else{
                $("#add").hide();
                $("#del").hide();
            }
        }
        // cmp.resiztable();
        cmp.mainquery(_curtab, true);
        isFirst = false;
    })

    /**
     * tabpage转radio
     */
    cmp.bulidTopHead = function (){
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
            cmp.checktabRadioClick();
        });
    }

    /**
     * radio点击触发clickTabpage
     */
    cmp.checktabRadioClick = function(){
        var checktab = $("input[name='checktab']:checked");
        var checkcode = checktab.attr("id");
        var checkname = checktab.attr("value");
        var hidebtns = checktab.attr("hidebtns");
        var tabobj = {};
        tabobj.code = checkcode;
        tabobj.name = checkname;
        tabobj.hidebtns = hidebtns;
        cmp.clickTabpage(tabobj);
    }

    /**
     * 主表查询.
     * goaltype -- 1 中长期， 0 年度
     */
    cmp.mainquery = function (goaltype, isquery){
        if (firstpage){
            var params = {};
            params.proguid = _proguid;
            params.pro_code = _procode;
            params.procode = _procode;
            params.showtab = showtab;
            params.adjadd = adjadd;
            params.selectbillguid = selectbillguid;
            params.pdmsave = pdmsave;
            params.tempcode = tempcode;
            params.showall = _showall;
            params.dataprovince = _dataprovince;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "getMainDatas", params, function(rs){
                totalgoals = rs.totalgoals;
                yeargoals = rs.yeargoals;
                if (_curtab == "year"){
                    goaldatatable.setDatas(yeargoals);
                } else {
                    goaldatatable.setDatas(totalgoals);
                }
                goaldatatable.clearSelected();
                datatable.setDatas([]);
                Ext.lt.ui.loadingClose();
                if (isquery) {
                    setTimeout(function(){
                        parent._isQuery = true;
                    },500);
                }
            },function(){
                Ext.lt.ui.loadingClose();
                Ext.lt.pmkpi.alert('目标查询失败！',function(){
                });
            });
        } else {
            if ("total"==goaltype){
                goaldatatable.setDatas(totalgoals);
            } else {
                goaldatatable.setDatas(yeargoals);
            }
            goaldatatable.clearSelected();
            datatable.setDatas([]);
        }
        firstpage = false;
    }

    /**
     * 页签点击操作.
     * @param obj
     */
    cmp.clickTabpage = function (obj){
        if (!firstpage){
            //1 表格切换之前先保存一下子表到主表行。
            var datas = datatable.getRecordSet().toArray();
            if (datas != null && datas.length > 0) {
                var goalguid = datas[0].goalguid;
                var mainsel = goaldatatable.getRecordset().query({guid:goalguid});
                if (mainsel.length > 0){
                    mainsel[0]["#indexs"] = datas;
                }
            }
            //2将主表保存到全局变量上
            if (_curtab =="total"){
                totalgoals = goaldatatable.getRecordset().toArray();
            } else {
                yeargoals = goaldatatable.getRecordset().toArray();
            }
            $("div[compid='toolbutton']").show();
            if(_SYSTEMSTYLE_ == "grey"){
                $(".tbtitle").show();
            }else{
                $("#add").show();
                $("#del").show();
            }
            if (_viewtype == "query" || (_isedittotal == "1" && obj.code == "total")) {
                $("div[compid='toolbutton']").hide();
                if(_SYSTEMSTYLE_ == "grey"){
                    $(".tbtitle").hide();
                }else{
                    $("#add").hide();
                    $("#del").hide();
                }
            }
            // cmp.resiztable();
            common.changTooltoolbuttontStatus(0,obj.hidebtns);
        }
        if(obj.code =="total"){
            _curtab ="total";
        } else {
            _curtab ="year";
            common.initDatatable(goaldatatable);
        }
        if (!isFirst) {
            cmp.mainquery(_curtab);
        }
        cmp.setTableColum(_curtab);
        if (_viewtype == "query") {
            for(var i=2; i<goaldatatable.getCols().length; i++){
                goaldatatable.getCols()[i].edit = false;
            }
            for(var i=2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            goaldatatable.redraw();
            datatable.redraw();
        }
    }

    /**
     * 重新刷新表格.
     */
    cmp.resiztable = function (){
        var width = $("#goaldatatable").width;
        if(_SYSTEMSTYLE_ == "grey"){
            goaldatatable.resize(width-20,_scrHeight*0.45);
        }else{
            goaldatatable.resize(width-20,_scrHeight*0.4);
        }
        datatable.resize(width-20,_scrHeight);
    }

    /**
     * 根据页签动态配置表格的列.
     * @param type -- 哪个页签显示列 total--》总体 year--》 年度
     */
    cmp.setTableColum = function(type){
        //目标列
        var goalcols = goaldatatable.config.data[0].columns;
        goalcols.push.apply(goalcols, _goaldisplaycols);
        _goaldisplaycols = [];
        //指标列
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if(col.colcode == "qnindexval" || col.colcode == "snindexval" || col.colcode == "weight"){//中期页签隐藏（上年指标值，前年指标值,指标分值权重）
                if (_curtab =="year"){
                    col.display = true;
                }else{
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        for (var a = 0, len = goalcols.length; a < len; a++) {
            var col = goalcols[a];
            if(col.colcode == "ratio"){//中期页签隐藏（权重指标比例）两个字段
                if (_curtab =="year"){
                    col.display = true;
                }else{
                    _goaldisplaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        goaldatatable.setSelfdefconfig({config: "{}"});
        goaldatatable.redraw();
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    /**
     * 主表的选中单选事件
     */
    Ext.lt.message.hook("fasp2datatable", "onRadioClick",function(d){
        //处理子表数据保存到主表上
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = goaldatatable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        cmp.query(d[4]);
    });

    /**
     * 子表查询
     * @param d -- 选中数据.
     */
    cmp.query = function(d){
        var indexs = d["#indexs"];
        if (indexs.length > 0){
            datatable.setDatas(indexs);
        } else {
            var params = {};
            params.goalguid = d.guid;
            params.proguid = _proguid;
            params.pro_code = _procode;
            params.procode = _procode;
            params.showtab = showtab;
            params.adjadd = adjadd;
            params.selectbillguid = selectbillguid;
            params.pdmsave = pdmsave;
            params.tempcode = tempcode;
            params.frametype = "PM001";
            params.showall = _showall;
            params.dataprovince = _dataprovince;
            Ext.lt.RCP.call(serviceid , "getSubData", params, function(rs){
                datatable.setDatas(rs.data);
            },function(){
                Ext.lt.pmkpi.alert('查询失败！',function(){
                });
            });
        }
    }

    /**
     * 主表的新增.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        if (_viewtype == "query") {
            alert("查看状态不可修改！");
            return;
        }else {
            if (_isedittotal == "1" && _curtab == "total") {//中期不可编辑
                alert("总体绩效不可修改！");
                return;
            } else {
                var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
                var newdata ={};
                newdata.guid = newguid;
                newdata.rowtype = "add";
                newdata["#indexs"] = [];
                newdata["#delindex"] = [];
                var n = goaldatatable.getRecordset().size(); //总数+1
                if (_curtab == "total"){
                    newdata.yearflag = '1';
                    newdata["goalname"] = "长期目标" +(n+1);
                } else {
                    newdata.yearflag = '0';
                    newdata["goalname"] = "年度目标" +(n+1);
                }
                newdata.pro_code = _procode;
                newdata.mainguid = _proguid;
                goaldatatable.getRecordSet().addData(newdata,999);
            }
        }
    });


    /**
     * 主表的删除.
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var selDatas = goaldatatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.pmkpi.alert('请选择要删除的目标数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择目标数据？\n【目标删除会同步删除配套的绩效指标】',null,function(is){
            if(is){
                var goalname = "长期目标";
                if(_curtab == "total" && selDatas[0]["rowtype"] != "add"){
                    deltotal.push(selDatas[0]); //总体删除
                } else if (_curtab == "year" && selDatas[0]["rowtype"] != "add") {
                    delyear.push(selDatas[0]); //年度删除
                }
                goaldatatable.removeData(selDatas);
                datatable.setDatas([]);
                if(_curtab =="year"){
                    goalname = "年度目标";
                }
                //处理各个目标的名称
                var arrs = goaldatatable.getRecordset().toArray();
                for(var i=0; i<arrs.length; i++){
                    arrs[i]["goalname"] = goalname + (i+1);
                }
                goaldatatable.reflashdata();
            }
        })
    });


    /**
     * 精准推荐方法.
     */
    cmp.recom = function(){
        var selDatas = goaldatatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.pmkpi.alert('请选择目标！',function(){
            });
            return;
        }
        var url = '/pmkpi/program/prjindex/recomindex.page';
        var params = {};
        params.proguid = _proguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = _prolev;//项目级别 123
        params.fromtype = "tree";
        params.showtab = showtab;
        params.goalguid = selDatas[0].guid;//目标guid
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,width,height,"指标推荐");
    }

    /**
     * 挑选指标.
     * frame -- 二级指标
     * guid -- guid
     */
    cmp.pick = function(){
        var data = cmp.getSeletdata("1");
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

    cmp.import = function(obj){
        //判断是否保存已经保存项目，即查询项目表里有没有数据
        var para = {};
        para.mainguid = _proguid;
        Ext.lt.ui.loadingShow();
        var resuleflag = Ext.lt.RCP.asyncall(serviceid , "chcekProgram", para);
        Ext.lt.ui.loadingClose();
        if(resuleflag=="false"){
            Ext.lt.pmkpi.alert("请先保存项目！",function(){});
            return;
        }
        //获取选中的目标数据
        var datas = goaldatatable.getSelected();
        //选中目标后才能导入指标
        if (datas.length > 0) {
            var goaldatas = Ext.lt.cloneobj(datas);
            var cols = goaldatatable.getCols();
            for (var c = 0,lenj = cols.length; c < lenj; c++) {
                if (cols[c].requirement == '1') {
                    delete goaldatas[0]["#delindex"];
                    delete goaldatas[0]["#indexs"];
                    var value = goaldatas[0][cols[c].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.pmkpi.alert("第" + (goaldatas[0]["_sortid"] + 1) + "行" + cols[c].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return;
                    }
                }
            }
            // 暂时写死导入模板的code
            var importcode = "005001";
            var vchtypeid = "C37567D248794199E053B11FA8C015A7";
            var tokenid = Ext.lt.getparam("tokenid");
            // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
            var params = {};
            params.vchtypeid = vchtypeid;
            params.tabtype = _curtab;
            params.proguid = _proguid;
            params.pagetype = "add";
            params.procode = _procode;
            params.goaldatas = goaldatas;
            window.importparam = params;
            // parent.document.getElementById("importdata");
            // $(window.frames[0].document).contents().find("#importdata").hide();
            Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
                window.parent.Ext.lt.outfile.window.close()
                parent.Ext.lt.pmkpi.impsucess();
            });
        }else{
            Ext.lt.pmkpi.alert("请选择目标进行指标导入！",function(){});
            return false;
        }
    }

    Ext.lt.pmkpi.impsucess = function (){
        Ext.lt.pmkpi.alert("导入成功！", function () {
            var goaldatas = goaldatatable.getSelected();
            Ext.lt.pmkpi.query(goaldatas[0]);
        });
    }

    Ext.lt.pmkpi.query = function (param) {
        var params = {};
        params.mainguid = param.mainguid;
        params.goalguid = param.guid;
        params.pro_code = param.pro_code;
        if (_curtab == "total"){
            params.yearflag = '1';
        } else {
            params.yearflag = '0';
        }
        Ext.lt.RCP.call(serviceid, "getIndexData", params, function (rs) {
            datatable.setDatas(rs.data);
        }, function () {
            Ext.lt.pmkpi.alert('查询失败！', function () {
            });
        });
    };

    /**
     * 复制总体绩效到年度
     */
    Ext.lt.pmkpi.copytotalindex = function () {
        Ext.lt.ui.confirm("是否复制总体到年度绩效？",{icon:"warn"},function(ret){
            if(ret){
                Ext.lt.ui.loadingShow();
                //1 先保存现在的数据。
                var datas = datatable.getRecordSet().toArray();
                if (datas != null && datas.length > 0) {
                    var goalguid = datas[0].goalguid;
                    var mainsel = goaldatatable.getRecordset().query({guid:goalguid});
                    if (mainsel.length > 0){
                        mainsel[0]["#indexs"] = datas;
                    }
                }
                goaldatatable.reflashdata();
                //2将主表保存到全局变量上
                if (_curtab == "total"){
                    totalgoals = goaldatatable.getRecordset().toArray();
                } else {
                    yeargoals = goaldatatable.getRecordset().toArray();
                }
                if (totalgoals.length > 0){
                    var len = yeargoals.length;
                    for(var i=0; i<totalgoals.length; i++){
                        var copygoal = {};
                        for (var key in totalgoals[i]) {
                            copygoal[key] = totalgoals[i][key];
                        }
                        copygoal["guid"] = getCreateguid(serviceid);
                        copygoal["yearflag"] = "0";
                        copygoal["#delindex"] = [];
                        copygoal["ordernum"] = (i+10+len);
                        copygoal.rowtype = "add";
                        copygoal["_locationposition"] = null;
                        copygoal["_sortid"] = null;
                        copygoal["goalname"] = "年度目标"+(len+i+1);
                        var tempindexs = totalgoals[i]["#indexs"];
                        var copyindexs = [];
                        var uuid = "";
                        for(var j=0; j<tempindexs.length; j++){
                            var copyindex = {};
                            for (var key in tempindexs[j]) {
                                copyindex[key] = tempindexs[j][key];
                            }
                            uuid = createUUID().replace(/-/g, '');
                            copyindex["yearflag"] = "0";
                            copyindex["goalguid"] = copygoal["guid"];
                            if (copyindex["levelno"] == 3){ //只有三级的给新增标识
                                copyindex["rowtype"] = "add";
                                copyindex["guid"] = uuid;
                                copyindex["goalguid"] = copygoal["guid"];
                            }
                            copyindexs.push(copyindex);
                        }
                        copygoal["#indexs"] = copyindexs;
                        yeargoals.push(copygoal);
                    }
                    //重新刷新主表
                    cmp.mainquery(_curtab);
                }
                Ext.lt.ui.loadingClose();
            }
        });
    }

    /**
     * 复制年度绩效到总体
     */
    Ext.lt.pmkpi.copyyearindex = function () {
        Ext.lt.ui.confirm("是否复制年度到总体绩效？",{icon:"warn"},function(ret){
            if(ret){
                Ext.lt.ui.loadingShow();
                //1 先保存现在的数据。
                var datas = datatable.getRecordSet().toArray();
                if (datas != null && datas.length > 0) {
                    var goalguid = datas[0].goalguid;
                    var mainsel = goaldatatable.getRecordset().query({guid:goalguid});
                    if (mainsel.length > 0){
                        mainsel[0]["#indexs"] = datas;
                    }
                }
                goaldatatable.reflashdata();
                //2将主表保存到全局变量上
                if (_curtab == "total"){
                    totalgoals = goaldatatable.getRecordset().toArray();
                } else {
                    yeargoals = goaldatatable.getRecordset().toArray();
                }
                if (yeargoals.length > 0){
                    var len = totalgoals.length;
                    for(var i=0; i<yeargoals.length; i++){
                        var copygoal = {};
                        for (var key in yeargoals[i]) {
                            copygoal[key] = yeargoals[i][key];
                        }
                        copygoal["guid"] = getCreateguid(serviceid);
                        copygoal["yearflag"] = "1";
                        copygoal["#delindex"] = [];
                        copygoal["ordernum"] = (i+10+len);
                        copygoal.rowtype = "add";
                        copygoal["_locationposition"] = null;
                        copygoal["_sortid"] = null;
                        copygoal["goalname"] = "长期目标"+(len+i+1);
                        var tempindexs = yeargoals[i]["#indexs"];
                        var copyindexs = [];
                        var uuid = "";
                        for(var j=0; j<tempindexs.length; j++){
                            var copyindex = {};
                            for (var key in tempindexs[j]) {
                                copyindex[key] = tempindexs[j][key];
                            }
                            uuid = createUUID().replace(/-/g, '');
                            copyindex["yearflag"] = "1";
                            copyindex["goalguid"] = copygoal["guid"];
                            if (copyindex["levelno"] == 3){ //只有三级的给新增标识
                                copyindex["rowtype"] = "add";
                                copyindex["guid"] = uuid;
                                copyindex["goalguid"] = copygoal["guid"];
                            }
                            copyindexs.push(copyindex);
                        }
                        copygoal["#indexs"] = copyindexs;
                        totalgoals.push(copygoal);
                    }
                    //重新刷新主表
                    cmp.mainquery(_curtab);
                }
                Ext.lt.ui.loadingClose();
            }
        });
    }

    /**
     * 整体的保存方法.
     * @returns {*}
     */
    cmp.save = function(){
        if (goaldatatable.getEditor()){
            goaldatatable.closeEdit();
        }
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        //1 表格切换之前先保存一下子表到主表行。
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = goaldatatable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        goaldatatable.reflashdata();
        //2将主表保存到全局变量上
        if (_curtab == "total"){
            totalgoals = goaldatatable.getRecordSet().toArray();
        } else {
            yeargoals = goaldatatable.getRecordSet().toArray();
        }
        //3请求后端保存
        if (!cmp.nullcheck()) return false;
        if (!cmp.checkAll()) return false;//先校验
        //4处理特殊符号
        totalgoals = getConverNewData(totalgoals);
        yeargoals = getConverNewData(yeargoals);
        deltotal = getConverNewData(deltotal);
        delyear = getConverNewData(delyear);
        if(totalgoals && totalgoals.length>0){
            for(var i=0;i<totalgoals.length;i++) {
                var goalname = totalgoals[i]["goalname"];
                var totalindex = totalgoals[i]["#indexs"];
                if (!common.checkSpaceValue(totalgoals[i],"绩效目标：" + goalname+"","goaldatatable")) return;//校验空格
                for(var j=0;j<totalindex.length;j++) {
                    if (!common.checkSpaceValue(totalindex[j],"绩效目标：" + goalname+"-绩效指标-第" + (totalindex[j]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                }
            }
        }
        if(yeargoals && yeargoals.length>0){
            for(var i=0;i<yeargoals.length;i++) {
                var goalname = yeargoals[i]["goalname"];
                var yearindex = yeargoals[i]["#indexs"];
                if (!common.checkSpaceValue(yeargoals[i],"绩效目标：" + goalname+"","goaldatatable")) return;//校验空格
                for(var j=0;j<yearindex.length;j++) {
                    if (!common.checkSpaceValue(yearindex[j],"绩效目标：" + goalname+"-绩效指标-第" + (yearindex[j]["_sortid"] + 1) + "行","datatable")) return;//校验空格
                }
            }
        }
        var params = {};
        params.totalgoals = totalgoals; //总体
        params.yeargoals = yeargoals;
        params.deltotal = deltotal; //总体删除
        params.delyear = delyear;
        params.busguid = _busguid;
        params.proguid = _proguid;
        params.pro_code = _procode;
        params.procode = _procode;
        params.showtab = showtab;
        params.adjadd = adjadd;
        params.selectbillguid = selectbillguid;
        params.pdmsave = pdmsave;
        params.tempcode = tempcode;
        params.isedittotal = _isedittotal;
        params.isnzzj = isnzzj;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "saveHbDatas", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            firstpage = true;
            deltotal =[];
            delyear = [];
            cmp.mainquery(_curtab);
        }
        return rs;
    }

    Ext.lt.pmkpi.inittreeindex = function (){
        firstpage = true;
        deltotal =[];
        delyear = [];
        cmp.mainquery(_curtab);
    }

    /**
     * 整体的校验.
     */
    cmp.nullcheck = function (){
        if (totalgoals.length == 0 && yeargoals.length > 0 && _isedittotal == "0"){
            Ext.lt.pmkpi.alert("请录入长期目标不可为空！",function(){});
            return false;
        }
        if (totalgoals.length > 0 && yeargoals.length == 0){
            Ext.lt.pmkpi.alert("请录入年度目标不可为空！",function(){});
            return false;
        }
        return  true;
    }

    /**
     * 表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function() {
        //校验目标
        var datas = goaldatatable.getRecordSet().toArray();
        var cols = datatable.getCols();
        var sumratio = 0;
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if(!datas[i].kpi_target || datas[i].kpi_target == ""){
                Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的绩效目标为必录项，必须有值。",{timeout:1},function(){});
                return;
            }
            sumratio+=Number(datas[i]['ratio']);

            var id = datas[i].guid;//目标id
            if(id != null && id !=""){
                //校验目标下的指标
                var yearlist = null;
                var totallist = null;
                if(datas[i].yearflag == "0"){
                    yearlist = datas[i]["#indexs"];
                }else{
                    totallist = datas[i]["#indexs"];
                }

                    if (yearlist != null && yearlist.length > 0) {
                        var sumweight = 0;
                        for (var a = 0, yleni = yearlist.length; a < yleni; a++) {
                            if (yearlist[a]["levelno"] == 3 && yearlist[a]["indexval"] == "" || yearlist[a]["indexval"] == undefined) {
                                Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的年度绩效指标指标值为必录项，必须有值。", {timeout: 1}, function () {
                                });
                                return;
                            }
                            if (yearlist[a]["levelno"] == 3) {
                                if(yearlist[a].computesign != 6 && yearlist[a].computesign != 9 && yearlist[a].computesign != 10 && (!yearlist[a].meterunit || yearlist[a].meterunit == "")){
                                    Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。", {timeout: 1}, function () {
                                    });
                                    return;
                                }
                            }
                            if (yearlist[a]['computesign'] == '9' && yearlist[a]['kpi_remark'] == undefined) {
                                Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的计算符号选择“定量（其他）”时指标值说明为必录项，必须有值。", {timeout: 1}, function () {
                                });
                                return;
                            }
                            for (var c = 0,lenj = cols.length; c < lenj; c++) {
                                if (cols[c].requirement == '1' && yearlist[a]["levelno"] == 3) {
                                    var value = yearlist[a][cols[c].colcode];
                                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                                        Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的" + cols[c].alias + "为必录项，必须有值。",{timeout:1},function(){});
                                        return false;
                                    }
                                }
                            }
                            if(yearlist[a]["levelno"] == 3){
                                sumweight+=Number(yearlist[a]['weight']);
                            }
                        }
                        var columns = datatable.config.data[0].columns;
                        var isvisiable = 0;
                        for(var num=0;num<columns.length;num++) {
                            if(columns[num]["colcode"] == "weight"){
                                isvisiable = columns[num]["isvisiable"];
                                break;
                            }
                        }
                        if(sumweight != 80 && isvisiable == 1){
                            Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标，指标权重之和应等于80分，请检查。",{timeout:1},function(){});
                            return false;
                        }
                    }



                    if (totallist != null && totallist.length > 0) {
                        for (var b = 0, tleni = totallist.length; b < tleni; b++) {
                            if (totallist[b]["levelno"] == 3 && totallist[b]["indexval"] == "" || totallist[b]["indexval"] == undefined) {
                                Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的年度绩效指标指标值为必录项，必须有值。", {timeout: 1}, function () {
                                });
                                return;
                            }
                            if (totallist[b]["levelno"] == 3) {
                                if(totallist[b].computesign != 6 && totallist[b].computesign != 9 && totallist[b].computesign != 10 && (!totallist[b].meterunit || totallist[b].meterunit == "")){
                                    Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。", {timeout: 1}, function () {
                                    });
                                    return;
                                }
                            }
                            if (totallist[b]['computesign'] == '9' && totallist[b]['kpi_remark'] == undefined) {
                                Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的计算符号选择“定量（其他）”时指标值说明为必录项，必须有值。", {timeout: 1}, function () {
                                });
                                return;
                            }
                            for (var e = 0,lenj = cols.length; e < lenj; e++) {
                                if (cols[e].requirement == '1' && totallist[b]["levelno"] == 3) {
                                    var value = totallist[b][cols[e].colcode];
                                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                                        Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的" + cols[e].alias + "为必录项，必须有值。",{timeout:1},function(){});
                                        return false;
                                    }
                                }
                            }
                        }
                    }
            }
        }

        var goalcolumns = goaldatatable.config.data[0].columns;
        var isvisiable = 0;
        for(var g=0;g<goalcolumns.length;g++) {
            if(goalcolumns[g]["colcode"] == "ratio"){
                isvisiable = goalcolumns[g]["isvisiable"];
                break;
            }
        }
        if(_curtab == "year" && sumratio != 100 && isvisiable == 1){
            Ext.lt.pmkpi.alert("指标权重比例合计应为100%。",{timeout:1},function(){});
            return false;
        }


        return true;
    }

    /**
     * 子表新增操作
     */
    cmp.add = function(obj,selguid){
        var data = [];
        if (!selguid) {
            data = cmp.getSeletdata("1");
            if(data.length != 1){
                Ext.lt.pmkpi.alert("请选择一条二级指标！",function(){});
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
        var newdata ={};
        var uuid = getCreateguid(serviceid);
        var indexcols = datatable.getCols();
        for (var i = 0, len = indexcols.length; i < len; i++) {
            var col = indexcols[i];
            var colcode = col.colcode;
            newdata[colcode] = "";
        }
        newdata.guid = uuid;
        newdata.levelno = 3;
        newdata.isleaf = 1;
        newdata.superid = data[0].guid;
        newdata.sindex = data[0].guid;
        newdata.findex = data[0].superid;
        newdata.is_deleted = "2";
        newdata.goalguid = data[0].goalguid;
        newdata.rowtype = "add";
        newdata.weight = 0;
        newdata.is_add="2";
        if (_curtab == "total") {
            newdata.yearflag = '1';
        } else {
            newdata.yearflag = '0';
        }
        datatable.getRecordSet().addData(newdata,999);
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
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){

        var key = obj.table.key;
        var uiconfig = obj.table.uiconfig;
        zcolumns = uiconfig.columns;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        if(key == "/pmkpi/program/report/treeindex"){
            for(var i=0; i<cols.length; i++){
                var col = cols[i];

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
                         el.innerText =  d.indexval!=undefined ? d.indexval : '';
                         table.getCol(c).mapping = null;
                         table.nowtype="input";
                         table.getCol(c).format = "";
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
                                Ext.lt.pmkpi.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.indexval = '';
                                return false;
                            }
                        }
                        if(d.computesign == "9"){
                            d["kpivalsource"] = d["indexval"];
                        }
                    }
                }
                if(col["colcode"]=="indexstandards"){
                    col.fn = function(l,c,data,col){
                        var indexstandardsstr ="";
                        if (standards && standards.length > 0) {
                            for(var i =0; i<standards.size() ; i++){
                                if(data.indexstandards == standards[i].guid){
                                    indexstandardsstr = standards[i].name;
                                }
                            }
                        }
                        return "<font style=\"margin-left:10px;\">"+indexstandardsstr+"</font>";
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
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.levelno == "3" && d.rowtype!="add"){
                            d.rowtype ="mod";
                        }
                    }
                }
                //推荐指标引用得指标，指标名称不可编辑，其他字段可编辑
                if(col["colcode"]=="name"){
                    col.oneditstart = function(table,el,l,c,d){
                        if (d.tindex != null) {
                            return false;
                        }
                    }
                }
                if(col["colcode"]=="obligate1"){
                    if (_viewtype != "query"){
                        col.style = " text-align:center;";
                        col.fn = function(l,c,data,col){
                            var html = "";
                            if(data.levelno == "2"){
                                html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:goalandindex.add("","'+data.guid+'")\'>新增</a>';
                            } else if(data.levelno == "3"){
                                html = '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'","'+data._locationposition+'","'+data.sindex+'")\'>删除</a>';
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
                        if(d.computesign && d.computesign != '6' && d.computesign != "9"  && d.computesign != "10"){
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
                if(col["colcode"]=="ratio" && _curtab == "total"){
                    col.isvisiable = 0;
                }

                if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                    col.style = "background-color:#f2f2f2;";
                    col.oneditstart = function (table, e, l, c, d) {
                        return false;
                    }
                }
            }
        }else{
            for(var i=0; i<cols.length; i++){
                var col = cols[i];
                if(col["colcode"]=="kpi_target"){
                    col.oneditstart = function (table, el, l, c, d) {
                        if (_isedittotal == "1" && _curtab == "total") {
                            return false;
                        }
                    }
                }
                if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                    col.style = "background-color:#f2f2f2;";
                    col.oneditstart = function (table, e, l, c, d) {
                        return false;
                    }
                }
            }
        }
    })


    /**
     * AI绩效指标智能推荐方法.
     * 业务场景：
     * 1.未填报目标一起推荐目标和指标，
     * 2.填报了目标
     *   2.1未勾选目标时推荐所有目标的指标，
     *   2.2勾选了目标推荐当前勾选目标的指标
     * 增加了plusprompt用来追加页面需要拼接的提示词
     */
    cmp.AIrecoindex = function (btn){
        // 关闭编辑状态
        if (goaldatatable.getEditor()){
            goaldatatable.closeEdit();
        }
        if (datatable.getEditor()){
            datatable.closeEdit();
        }
        // 推荐之前先保存一下子表到主表行，避免录入信息丢失。
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = goaldatatable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        goaldatatable.reflashdata();
        var url = '/pmkpi/program/airecoindex.page';
        var btnconfig = eval('(' + btn.config + ')');
        var params = {};
        params.procode = _procode;
        params.fromtype = "tree";
        params.recomtype = "AI";
        params.frametype = "PM001";
        params.api_key = btnconfig.api_key;
        params.api_code = btnconfig.api_code;
        params.is_profrompage = btnconfig.is_profrompage;
        params.loadingtips = btnconfig.loadingtips;
        if (_curtab == "total"){
            params.yearflag = '1';
        } else {
            params.yearflag = '0';
        }
        var goaldatas = goaldatatable.getRecordSet(); // 当前页面目标数据
        var selgoal = goaldatatable.getSelected(); // 选中的目标数据
        var confirmmsg = "您还没有填写绩效目标，确认一同推荐绩效目标和绩效指标吗？";
        if(selgoal.size()>0 && !!selgoal[0].kpi_target){
            _selgoalguid = selgoal[0].guid;
            confirmmsg = "您选择了"+selgoal[0].goalname+"，确认根据目标【"+selgoal[0].kpi_target+"】推荐绩效指标吗？"
            params.plusprompt = "绩效目标："+goaldatatable.getSelected()[0].kpi_target+"，";// 选中目标的目标值 为页面额外提示词
        }else if (selgoal.size()>0 && !selgoal[0].kpi_target){
            _selgoalguid = selgoal[0].guid;
            confirmmsg = "您选中的绩效目标内容为空，确认一同推荐绩效目标和绩效指标吗？";
        }else if (goaldatas.size()>0){
            confirmmsg = "您没有选择绩效目标，确认根据所有已填报的绩效目标推荐绩效指标吗？";
            var goalstr = "";
            var goaldatasary = goaldatatable.getRecordSet().toArray();
            var goalcount = 1;
            for(var i=0; i<goaldatasary.length; i++){
                if(goaldatasary[i].kpi_target && goaldatasary[i].kpi_target!=""){
                    goalstr += ("绩效目标"+goalcount+"："+goaldatasary[i].kpi_target+"，");
                    goalcount ++;
                }
            }
            params.plusprompt = goalstr;// 全部目标值拼接 为页面额外提示词
        }
        Ext.lt.ui.confirm(confirmmsg,{icon:"warn"},function(ret){
            if(ret){
                url = Ext.lt.pmkpi.genPageUrl(url, params);
                var height = Math.floor(document.documentElement.clientHeight * 0.95);
                var width =  Math.floor(document.documentElement.clientWidth * 0.95);
                Ext.lt.ui.openModalWindow(url,width,height,"绩效指标智能推荐");
            }
        });
    }

    /**
     * AI绩效指标智能推荐引用到本页面.
     * 根据目标值kpi_target匹配AI推荐的指标分别加载到对应目标内
     */
    Ext.lt.pmkpi.AIrecoindexAdd = function (selRecords){
        var success = true;
        // 0 选中的推荐数据校验
        for (var i = 0; i < selRecords.length; i++) {
            var indexdata = selRecords[i];
            if(!indexdata.findex || !indexdata.sindex || !indexdata.computesign){
                Ext.lt.pmkpi.alert("推荐的绩效指标存在异常，请重新推荐！");
                return false;
            }
        }
        // 1 整理选中的推荐数据到 indexmap
        var tempobj = {};
        var sindex = "";
        var name = "";
        var kpi_target = "";
        var indexmap = {};
        for (var i = 0; i < selRecords.length; i++) {
            tempobj = selRecords[i];
            sindex = tempobj["sindex"];
            name = tempobj["name"];
            kpi_target = tempobj["kpi_target"];
            if (!!kpi_target && kpi_target != "" && !!name && name != "") { // 存在目标和三级指标的才保存替换
                var uuid = createUUID().replace(/-/g, '');
                tempobj.guid = uuid;
                tempobj.tindex = tempobj.guid; // 湖北AI指标推荐tindex无指标库来源给guid
                tempobj.superid = tempobj.sindex;
                tempobj.levelno = 3;
                tempobj.isleaf = 1;
                tempobj._isleaf = 1;
                tempobj.rowtype = "add";
                if (_curtab == "total") {
                    tempobj.yearflag = "1";
                } else if (_curtab == "year") {
                    tempobj.yearflag = "0";
                }
                tempobj.targetvalue = tempobj.kpi_val;
                tempobj.indexvalue = ""; // 指标值清空
                tempobj.indexval = "";
                tempobj.kpi_val = "";
                tempobj.kpi_remark = "智能指标推荐";
                if (!indexmap[kpi_target]) {
                    indexmap[kpi_target] = [];
                }
                indexmap[kpi_target].push(tempobj);
            }
        }
        // 2 确定要填充的目标数据是否存在
        var setgoaldatas;
        // _selgoalguid存在，即选中一个目标的情况
        if(!!_selgoalguid){
            setgoaldatas = goaldatatable.getRecordSet().query({guid:_selgoalguid});
        }else if ((_isedittotal != "1" && _curtab == "total") || _curtab == "year"){
            setgoaldatas = goaldatatable.getRecordSet().toArray();
        }
        if(setgoaldatas.length>0  && !!setgoaldatas[0].kpi_target){
            // 2.1 目标表存在填报信息，在已有的目标上处理
            for(var i=0;i<setgoaldatas.length;i++) {
                var goalguid = setgoaldatas[i]["guid"];
                var kpi_target = setgoaldatas[i]["kpi_target"];
                var goalindexs = setgoaldatas[i]["#indexs"];
                var indexs = indexmap[kpi_target] || {};
                for(var i=0;i<indexs.length;i++) {
                    indexs[i].goalguid = goalguid;
                }
                if(goalindexs.length>0 && !!_selgoalguid){
                    // 2.1.1 目标的指标存在，选中一个目标，直接全部追加到目标中
                    for (var goal in indexmap) {
                        var oneindexs = indexmap[goal] || {};
                        for(var i=0;i<oneindexs.length;i++) {
                            oneindexs[i].goalguid = goalguid;
                        }
                        goalindexs.push.apply(goalindexs, oneindexs);
                    }
                }else if(goalindexs.length>0 && !_selgoalguid){
                    // 2.1.2 目标的指标存在，直接追加选中的推荐数据
                    goalindexs.push.apply(goalindexs, indexs);
                }else{
                    // 2.1.3 目标的指标不存在，先获取空模板再追加选中的推荐数据
                    _nulltempindexs = cmp.getnulltempindexs();
                    if(_nulltempindexs.length>0){
                        for(var i=0;i<_nulltempindexs.length;i++) {
                            _nulltempindexs[i].goalguid = goalguid;
                        }
                        indexs.unshift.apply(indexs, _nulltempindexs);
                        setgoaldatas["#indexs"] = indexs;
                    }
                }
            }
            goaldatatable.setDatas(setgoaldatas);
        }else{
            // 2.2 目标表不存在填报信息，需要新增目标再处理
            _nulltempindexs = cmp.getnulltempindexs();
            if(_nulltempindexs.length>0){
                for (var kpi_target in indexmap) {
                    // 2.2.1 根据indexmap的每个目标生成一条newdata,并给#indexs赋值
                    var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
                    var newdata ={};
                    newdata.guid = newguid;
                    newdata.rowtype = "add";
                    newdata["kpi_target"] = kpi_target;
                    for(var i=0;i<_nulltempindexs.length;i++) {
                        _nulltempindexs[i].goalguid = newdata.guid;
                    }
                    var indexs = indexmap[kpi_target] || {};
                    for(var i=0;i<indexs.length;i++) {
                        indexs[i].goalguid = newdata.guid;
                    }
                    indexs.unshift.apply(indexs, _nulltempindexs);
                    newdata["#indexs"] = indexs;
                    newdata["#delindex"] = [];
                    var n = goaldatatable.getRecordset().size(); //总数+1
                    if (_curtab == "total"){
                        newdata.yearflag = '1';
                        newdata["goalname"] = "长期目标" +(n+1);
                    } else {
                        newdata.yearflag = '0';
                        newdata["goalname"] = "年度目标" +(n+1);
                    }
                    newdata.pro_code = _procode;
                    newdata.mainguid = _proguid;
                    goaldatatable.getRecordSet().addData(newdata,999);
                }
            }else{
                // 指标层级模板数据为空的异常情况
                success = false;
                Ext.lt.pmkpi.alert("引用指标失败,请联系管理员！");
            }
        }
        // 3 成功提示和页面处理
        if(success){
            Ext.lt.pmkpi.alert("智能指标推荐完成，已推荐指标"+selRecords.length+"个！",function(){
                goaldatatable.clearSelected();
                datatable.setDatas([]);
                _selgoalguid = "";
                Ext.lt.ui.modalWindow.close();
            });
        }
    }

    /**
     * 获取空指标模板数据
     * @returns {*}
     */
    cmp.getnulltempindexs = function (){
        if(_nulltempindexs != null){
            return _nulltempindexs;
        }
        var params = {};
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.goalguid = newguid;
        params.proguid = _proguid;
        params.pro_code = _procode;
        params.procode = _procode;
        params.showtab = showtab;
        params.adjadd = adjadd;
        params.selectbillguid = selectbillguid;
        params.pdmsave = pdmsave;
        params.tempcode = tempcode;
        params.frametype = "PM001";
        params.showall = _showall;
        params.dataprovince = _dataprovince;
        var rs = Ext.lt.RCP.asyncall(serviceid , "getSubData", params);
        return rs.data;
    }

    Ext.lt.message.hook("layout", "endlayout2", function(){
        if (typeof(goaldatatable) != "undefined" && goaldatatable != null) {
            goaldatatable.resize(undefined, height*0.6);
        }
        if (typeof(datatable) != "undefined" && datatable != null) {
            datatable.resize(undefined, height);
        }
    });
    return cmp;
}

/**
 * 子表行级删除.
 * @param guid
 * @param _locationposition
 * @param sindex
 */
function indexdel(guid,_locationposition,sindex) {
    Ext.lt.ui.confirm("你确定删除选定的数据？",{icon:"warn"},function(ret){
        if(ret){
            var tempArray = goaldatatable.getSelected();
            var goalguid = tempArray[0]["guid"];
            var mainsel = goaldatatable.getRecordset().query({guid:goalguid});
            var datas = datatable.getRecordSet().toArray();
            if(datas!=null && datas.length > 0) {
                for (var i = 0; i < datas.length; i++) {
                    var selectDatas = datas[i];
                    if (guid == selectDatas.guid) {
                        if (mainsel.length > 0 && selectDatas["rowtype"] !="add"){
                            mainsel[0]["#delindex"].push(selectDatas);
                        }
                        datatable.removeData(selectDatas);
                        gatherWeight(selectDatas.sindex);
                    }
                }
            }
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
            if ((rowarr[i].isleaf == "1" || rowarr[i]._isleaf == "1") && rowarr[i].levelno == "3") {
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
 * 特殊字替换
 */
function getConverNewData (goals) {
    if (goals) {
        //处理特殊符号
        for (var x = 0; x < goals.length; x++) {
            goals[x].kpi_target = goals[x].kpi_target == "" || goals[x].kpi_target == undefined ? "" : convertStr(goals[x].kpi_target);
            goals[x].pro_name = goals[x].pro_name == "" || goals[x].pro_name == undefined ? "" : convertStr(goals[x].pro_name);
            var indexlist = goals[x]["#indexs"];
            var delindexlist = goals[x]["#delindex"];
            for (var y = 0; y < indexlist.length; y++) {
                if(indexlist[y]["levelno"] == 3){
                    indexlist[y]["pro_name"] = indexlist[y]["pro_name"] == "" || indexlist[y]["pro_name"] == undefined ? "" :convertStr(indexlist[y]["pro_name"]);
                    indexlist[y]["name"] = indexlist[y]["name"] == "" || indexlist[y]["name"] == undefined ? "" :convertStr(indexlist[y]["name"]);
                    indexlist[y]["lv3_perf_ind_name"] = indexlist[y]["lv3_perf_ind_name"] == "" || indexlist[y]["lv3_perf_ind_name"] == undefined ? "" :convertStr(indexlist[y]["lv3_perf_ind_name"]);
                    indexlist[y]["kpi_content"] = indexlist[y]["kpi_content"] == "" || indexlist[y]["kpi_content"] == undefined ? "" :convertStr(indexlist[y]["kpi_content"]);
                    indexlist[y]["value_remark"] = indexlist[y]["value_remark"] == "" || indexlist[y]["value_remark"] == undefined ? "" :convertStr(indexlist[y]["value_remark"]);
                    indexlist[y]["indexval"] = indexlist[y]["indexval"] == "" || indexlist[y]["indexval"] == undefined ? "" :convertStr(indexlist[y]["indexval"]);
                    indexlist[y]["kpi_val"] = indexlist[y]["kpi_val"] == "" || indexlist[y]["kpi_val"] == undefined ? "" :convertStr(indexlist[y]["kpi_val"]);
                }
            }
            for(var z = 0; z < delindexlist.length; z++){
                if(delindexlist[z]["levelno"] == 3){
                    delindexlist[z]["pro_name"] = delindexlist[z]["pro_name"] == "" || delindexlist[z]["pro_name"] == undefined ? "" :convertStr(delindexlist[z]["pro_name"]);
                    delindexlist[z]["name"] = delindexlist[z]["name"] == "" || delindexlist[z]["name"] == undefined ? "" :convertStr(delindexlist[z]["name"]);
                    delindexlist[z]["lv3_perf_ind_name"] = delindexlist[z]["lv3_perf_ind_name"] == "" || delindexlist[z]["lv3_perf_ind_name"] == undefined ? "" :convertStr(delindexlist[z]["lv3_perf_ind_name"]);
                    delindexlist[z]["kpi_content"] = delindexlist[z]["kpi_content"] == "" || delindexlist[z]["kpi_content"] == undefined ? "" :convertStr(delindexlist[z]["kpi_content"]);
                    delindexlist[z]["value_remark"] = delindexlist[z]["value_remark"] == "" || delindexlist[z]["value_remark"] == undefined ? "" :convertStr(delindexlist[z]["value_remark"]);
                    delindexlist[z]["indexval"] = delindexlist[z]["indexval"] == "" || delindexlist[z]["indexval"] == undefined ? "" :convertStr(delindexlist[z]["indexval"]);
                    delindexlist[z]["kpi_val"] = delindexlist[z]["kpi_val"] == "" || delindexlist[z]["kpi_val"] == undefined ? "" :convertStr(delindexlist[z]["kpi_val"]);
                }
            }
        }
    }
    return goals ;
}