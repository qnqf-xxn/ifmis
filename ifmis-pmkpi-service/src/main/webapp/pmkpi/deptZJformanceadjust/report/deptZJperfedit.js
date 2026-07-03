if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
var serviceid;
var deptcmp;
var indexprojects = [];
Ext.lt.pmkpi.deptZJperfedit = function(config, service){
	deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
	//window.parent.Ext.lt.pmkpi.childwindow = window;
	var cmp = {};
 	serviceid = service;
 	var _mainguid = config.mainguid,
    _projguid = config.projguid,
	_saveAgency = config.saveAgency,
	_tabData = config.tabData,
	_scrWidth =document.body.clientWidth,
	_scrHeight =document.body.clientHeight,
	_workflow = config.workflow,
	_menuid = config.menuid,
    funcresp = config["funcresp"],//部门职责
	_viewtype = config.viewtype;//区分是否查询:query是查询，其他可修改
	//根据组件id存放表名
	Ext.lt.pmkpi.isadd = false;
	/**
	 * 页签方法
	 */
	cmp.clickTabpage = function(obj){
        //获取组件表中没有展示的页签组件id，隐藏相对应页签内容
        var _tabData = edittabpage.cfg.data;
        var main = edittabpage.cfg.main;
        var hidDiv = [];
        for (var i=0; i<main.length; i++) {
            var isshow = false;
            for (var j=0; j<_tabData.length; j++){
                if (main[i] == _tabData[j].componentid) {
                    isshow = true;
                    break;
                }
            }
            if (!isshow && main[i] != 'edittabpage') {
                hidDiv.push(main[i]);
            }
        }
        obj.hiddiv = hidDiv;
        if (_viewtype != "query" && _onclickid == 'perfindexdatatable'){
            var backflg = cmp.checkAll();
            if (false == backflg){
                return backflg;
            }
        }
        if (_onclickid == 'budgetdatatable'){
            /**
             * 重写纳入预算接口内容.
             * @returns {boolean}
             */
            budgetdatatable.checkAll = function() {
                var datas = budgetdatatable.getCheckRecordSet().toArray();
                var cols = budgetdatatable.getCols();
                for (var i = 0,leni = datas.length; i < leni; i++) {
                    for (var j = 0,lenj = cols.length; j < lenj; j++) {
                        if (cols[j].requirement == '1') {
                            var value = datas[i][cols[j].colcode];
                            if (value  == 0){
                                continue;
                            }
                            if (value == null || value == "" || ("" + value).trim().length == 0) {
                                alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。");
                                return false;
                            }
                        }
                    }
                }
                return true;
            }
		}
        deptcmp.tabpageOnclick(obj, _tabData, toolbutton);
    }

    /**
     * 编辑区组件保存.
     */
    cmp.infosave = function (obj){
        var params= {};
        params.isadd = true;
        params.workflow = _workflow;
        params.viewtype = _viewtype; //判断是修改还是新增.
        //部门指标校验行数据.
        if (_onclickid == 'perfindexdatatable'){
          var backflg = cmp.checkAll();
          if (false == backflg){
          	 return backflg;
		  }
        }
        deptcmp.savedatas(obj, params);
    }
    /**
     * 处理附件
     */
    Ext.lt.message.hook("perfcommon", "iframeinit",function (obj) {
        var params = obj.params;
        params.mainguid = _mainguid;
        params.projguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.viewtype = _viewtype; //判断是查看还是可操作
    });

	/**
	 * 新增行.
	 */
	Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
		var config = editdatatable.config;
		var componentid = config.id;
		if(_onclickid == componentid){
			var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
			var newdata ={};
			newdata.guid = newguid;
			newdata.mainguid = _mainguid;
            newdata.agencyguid = _saveAgency;
			newdata.rowtype = "add";
			Ext.lt.pmkpi.isadd = true;
			if ("perfindexdatatable" == componentid){
                newdata.findex = "4";
                newdata.projects = [];
                var arr = [];
                arr.push("4");
                arr.push("4");
                arr.push("产出与效果");
                perfindexdatatable.getCol("findex").mapper.datas.push(arr);
                perfindexdatatable.getCol("findex").mapping["4"] = arr;
			}
			eval(_onclickid).getRecordSet().addData(newdata,999);
		}
	});

	/**
	 * 删除行
	 */
	Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
		var config = editdatatable.config;
		var componentid = config.id;
		if(_onclickid == componentid){
			var selDatas = eval(_onclickid).getSelected();
			if (selDatas.size() <= 0) {
				Ext.lt.ui.alert('请选择要删除的数据！',function(){
				});
				return;
			}
			Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
				if(is){
					eval(_onclickid).removeData(selDatas);
					//deptcmp.amtTotal(eval(_onclickid));
				}
			})
		}
	});
	/**
	 * 重画表格
	 */
	Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
		var config = obj.config;
		var componentid = config.id;
		_table_param[componentid] = obj.uiconfig.tablecode;
		_table_param[componentid + "_defquery"] = obj.uiconfig.defquery;
		_table_param[componentid + "_orderby"] = obj.uiconfig.orderby;
		_table_param[componentid + "_busguid"] = config.busguid; //审核定义调用
		_table_param[componentid + "_totaltag"] = obj.uiconfig.totaltag;
		if (_viewtype == "query") {
			config.edit = false;
			config.addrow = false;
		}
	});

    /**
     * 页面初始化加载，查看的话不显示按钮
     */
	$(function(){
		if (_viewtype == "query") {
			try{
                $("div[compid='toolbutton']").hide();
                $(".winfooter").hide();
			}catch (e){
				document.getElementsByClassName("winfooter")[0].style.display = "none";
			}
			// document.getElementById("tabpage").style.display = "none";
			document.getElementById("add").style.display = "none";
			document.getElementById("del").style.display = "none";
            for(var i = 2; i<perfindexdatatable.getCols().length; i++){
                perfindexdatatable.getCols()[i].edit = false;
            }
            for(var i = 2; i<budgetdatatable.getCols().length; i++){
                budgetdatatable.getCols()[i].edit = false;
            }
            for(var i = 2; i<indexprodatatable.getCols().length; i++){
                indexprodatatable.getCols()[i].edit = false;
            }
            perfindexdatatable.redraw();
            budgetdatatable.redraw();
            indexprodatatable.redraw();
		}
        // 首次打开 tabpageOnclick里document.getElementById(showid).style.display = "block"
        // 无法显示编辑区，_input变量不存在，数据无法加载（切换页签无问题）
        if (_onclickid == 'infoeditform'){
            var params = {};
            params.mainguid = _mainguid;
            params.projguid = _projguid;
            params.saveAgency = _saveAgency;
            params.componentid = "infoeditform";
            deptcmp.queryedit(params, "infoeditform");
        }
        //初始化表格组件
        deptcmp.initDatatable(perfindexdatatable);
        deptcmp.initDatatable(budgetdatatable);
        deptcmp.initDatatable(indexprodatatable);
	});

	/**
	 * 点击表格类型页签处理消息
	 */
	Ext.lt.message.hook("perfcommon", "tableinit",function(obj){
		var params = obj.params;
		params.menuid = _menuid;
		params.mainguid = _mainguid;
		params.uikey = eval(obj.id)["key"];
        params.componentid = obj.id;
        params.projguid = _projguid;
	});

	/**
	 * 点击编辑区类型处页签理消息
	 */
	Ext.lt.message.hook("perfcommon", "editinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.saveAgency = _saveAgency;
        params.componentid = obj.id;
        params.projguid = _projguid;
	});

	/**
	 * 点击报表类型处理消息
	 */
	Ext.lt.message.hook("perfcommon", "reportinit",function(obj){
		var params = obj.params;
		params.mainguid = _mainguid;
		params.saveAgency = _saveAgency;
        params.projguid = _projguid;
	});
	
	/**
	 * 保存编辑区之前封装参数
	 */
	Ext.lt.message.hook("perfcommon", "beforeEditsave",function(obj){
		var params = obj.params;
		params.uikey = eval(obj.id).cfg["key"];
		params.pagetype = eval(obj.id).cfg["pagetype"];//区分主编辑区
		params.componentid = obj.id; //区分哪个组件
	});
	/**
	 * 保存表格之前封装参数
	 */
	Ext.lt.message.hook("perfcommon", "beforeTablesave",function(obj){
		var params = obj.params;
		params.uikey = eval(obj.id)["key"];
        params.componentid = obj.id; //区分哪个组件
        params.componentid = obj.id;
	});

	/**
	 * 表格查询方法处理.
	 */
	Ext.lt.message.hook("perfcommon", "tablequery",function(obj){
		if (obj.componentid == "perfindexdatatable" || obj.componentid =="budgetdatatable") {
            eval(obj.componentid).redraw();
		}
		if (obj.componentid == "perfindexdatatable" ) {
			setTimeout(function(){
                amtTotal(perfindexdatatable);
                //perfindexdatatable.resetSum();
			},100);

		}
        if (obj.componentid =="budgetdatatable") {
            setTimeout(function(){
                cmp.bgtamtTotal("bgtamt1");
                cmp.bgtamtTotal("bgtamt2");
                cmp.bgtamtTotal("bgtamt3");
                cmp.bgtamtTotal("coupleamt");
                var parent_sel_rows = budgetdatatable.getRecordset().query({indexguid:"FIXEDBGTLINKBGTINFO0002"});
                var parent_sel_obj = parent_sel_rows[0];
                var _sortid = parent_sel_obj._sortid;
                budgetdatatable.reflash(_sortid);
            },100);
        }
	});

	cmp.close = function () {
		Ext.lt.ui.closeModalWindow();
		window.parent.Ext.lt.pmkpi.query();
	}
    /**
	 * 表格重画表格之前.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj) {
        var componentid =  obj.table.config.id; //表格组件名称
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if ("perfindexdatatable" == componentid){ //部门整体绩效指标
                if (col["colcode"] == "fun_res_code") { //职能职责自定义回显翻译控制 filtersql = "bgt_dept_code = '#agencyguid'" 固定
                    col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                        var newstyle = 'text-align:center;';
                        var styleresult = updateStyle(style, newstyle);
                        return styleresult;
                    }
                    col.fn = function(l,c,row,val){
                        var fun_res_code = row["fun_res_code"];
                        var perfindexcfgcols = perfindexdatatable.config.data[0].columns;
                        var filtersql = ""; // bgt_dept_code = '#agencyguid'
                        for(var i = 0; i<perfindexcfgcols.length; i++){
                            if(perfindexcfgcols[i].colcode == "fun_res_code"){
                                filtersql = perfindexcfgcols[i].filtersql;
                                break;
                            }
                        }
                        function extractFields(sql) {
                            var regex = /(\w+)\s*=\s*['"]#(\w+)['"]/;
                            var match = sql.match(regex);
                            return match ? { field: match[1], value: match[2] } : null;
                        }
                        var html = val;
                        if(!!filtersql){
                            var result = extractFields(filtersql);
                            if(!!result){
                                for(var i=0; i<funcresp.length; i++){
                                    // 匹配filter条件 和 职责编码
                                    if(funcresp[i][result.field] == row[result.value] && funcresp[i]["code"] == fun_res_code){
                                        html = funcresp[i]["code"] +"-"+funcresp[i]["name"];
                                        row["fun_res_name"] = funcresp[i]["name"];
                                    }
                                }
                            }
                        }
                        return html;
                    }
                }
                if (col["colcode"] == "proselect") {
                    col.style = " text-align:center;";
                    col.fn = function(l,c,row,val){
                        if (row["datatable_do_sum"] == true){
                            return "";
                        }
                        var html =  '<a title = "选择" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:pmkpideptZJedit.selpros("'+row.guid+'",'+Object.toJSON(row.projects)+')\'>选择</a>';
                        return html;
                    }
                }
                if(col["colcode"]=="computesign"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6'){
                            /*if(!checkReferencepole(d.indexval)){
                                d.indexval = '';
                                d.kpi_val1 = '';
                                d.kpi_val2 = '';
                                d.kpi_val3 = '';
                                return false;
                            }*/
                            var re = /^\d*\.{0,1}\d{0,2}$/;
                            if(!re.test(d.indexval)){
                                d.indexval = '';
							 }
                            if(!re.test(d.kpi_val1)){
                                d.kpi_val1 = '';
                            }
                            if(!re.test(d.kpi_val2)){
                                d.kpi_val2 = '';
                            }
                            if(!re.test(d.kpi_val3)){
                                d.kpi_val3 = '';
                            }
                        } else if (d.computesign && d.computesign == "6") {
                            d.meterunit = '';
						}
                    }
                }
                if(col["colcode"]=="indexval"){
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
                    }
                }
                if(col["colcode"]=="snindexval"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                            if(!checkReferencepole(d.snindexval)){
                                d.snindexval = '';
                                return false;
                            }
                        }
                        if(d.snindexval!=''){
                            var computesign = d.computesign;
                            if (!d.computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.snindexval = '';
                                return false;
                            }
                        }
                    }
                }
                if(col["colcode"]=="kpi_val"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                            if(!checkReferencepole(d.kpi_val)){
                                d.kpi_val = '';
                                return false;
                            }
                        }
                        if(d.kpi_val!=''){
                            var computesign = d.computesign;
                            if (!d.computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.kpi_val = '';
                                return false;
                            }
                        }
                    }
                }
                if(col["colcode"]=="kpi_val2023"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                            if(!checkReferencepole(d.kpi_val2023)){
                                d.kpi_val2023 = '';
                                return false;
                            }
                        }
                        if(d.kpi_val2023!=''){
                            var computesign = d.computesign;
                            if (!d.computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.kpi_val2023 = '';
                                return false;
                            }
                        }
                    }
                }
                if(col["colcode"]=="kpi_val1"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                            if(!checkReferencepole(d.kpi_val1)){
                                d.kpi_val1 = '';
                                return false;
                            }
                        }
                        if(d.kpi_val1!=''){
                            var computesign = d.computesign;
                            if (!d.computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.kpi_val1 = '';
                                return false;
                            }
                        }
                    }
                }
                if(col["colcode"]=="kpi_val2"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                            if(!checkReferencepole(d.kpi_val2)){
                                d.kpi_val2 = '';
                                return false;
                            }
                        }
                        if(d.kpi_val2!=''){
                            var computesign = d.computesign;
                            if (!d.computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.kpi_val2 = '';
                                return false;
                            }
                        }
                    }
                }
                if(col["colcode"]=="kpi_val3"){
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                            if(!checkReferencepole(d.kpi_val3)){
                                d.kpi_val3 = '';
                                return false;
                            }
                        }
                        if(d.kpi_val3!=''){
                            var computesign = d.computesign;
                            if (!d.computesign) {
                                Ext.lt.ui.alert("请先选择计算符号！",{timeout:1},function(){});
                                d.kpi_val3 = '';
                                return false;
                            }
                        }
                    }
                }
                if(col["colcode"]=="score"){
                    col.oneditend = function (table, el, l, c, d) {
                        amtTotal(perfindexdatatable);
                    }
                }
                if (_viewtype == "query") {
                    col.isvisiable = 0;
				}
			}

            if ("budgetdatatable" == componentid){ //预算挂钩机制
                if (col["colcode"] == "baseperiod") { //基期指标值
                    col.oneditstart = function(table, e, l, c, d){
                        if(d["indexguid"] == "FIXEDBGTLINKBGTINFO0001" || d["indexguid"] == "FIXEDBGTLINKBGTINFO0002"){
                            return false;
                        }
                    }
                }
                if (col["colcode"] == "couplerate") { //挂钩比例
                    //col.style = " text-align:center;";
                    col.fn = function(l,c,row,val){
                        if(row["indexguid"] == "FIXEDBGTLINKBGTINFO0001" || row["indexguid"] == "FIXEDBGTLINKBGTINFO0002"){
                            var html =  '&nbsp&nbsp--';
                            return html;
                        } else {
                            return val;
                        }
                    }
                    col.oneditstart = function(table, e, l, c, d){
                        if(d["indexguid"] == "FIXEDBGTLINKBGTINFO0001" || d["indexguid"] == "FIXEDBGTLINKBGTINFO0002"){
                            return false;
                        }
                    }
                }
                if (col["colcode"] == "coupleamt") { //挂钩金额
                    //col.style = " text-align:left;";
                    col.fn = function(l,c,row,val){
                        if(row["indexguid"] == "FIXEDBGTLINKBGTINFO0001"){
                            var html =  '--&nbsp&nbsp';
                            return html;
                        } else {
                            return val;
                        }
                    }
                    col.oneditstart = function(table, e, l, c, d){
                        if(d["indexguid"] == "FIXEDBGTLINKBGTINFO0001"){
                            return false;
                        }
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        cmp.bgtamtTotal("coupleamt");
                    }
                }
                if (col["colcode"] == "bgtamt1") { //处理预算金额汇总
                    col.oneditend = function (table, el, l, c, d) {
                        cmp.bgtamtTotal("bgtamt1");
                    }
                }
                if (col["colcode"] == "bgtamt2") { //处理预算金额汇总
                    col.oneditend = function (table, el, l, c, d) {
                        cmp.bgtamtTotal("bgtamt2");
                    }
                }
                if (col["colcode"] == "bgtamt3") { //处理预算金额汇总
                    col.oneditend = function (table, el, l, c, d) {
                        cmp.bgtamtTotal("bgtamt3");
                    }
                }
            }
            if ("indexprodatatable" == componentid){ //指标对应的项目关系表
                if(col["colcode"] == "fun_res_code"){
                    var findex = "";
                    var subfindex = "";
                    col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                        if(j==1){
                            var tabledata = indexprodatatable.getRecordSet().toArray();
                            var statnum = 0;
                            if(i==statnum){
                                findex = Ext.lt.cloneobj(rs["fun_res_code"]);
                            }
                            if(findex == rs["fun_res_code"]){
                                style ='style="border-bottom-style:none;text-align:center;position:relative;padding-top:5px;';
                            } else {
                                style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
                            }
                            findex = Ext.lt.cloneobj(rs["fun_res_code"]);
                            if(i == tabledata.length-1){
                                style =style +'border-bottom-style:solid;"';
                            } else {
                                style =style + '"';
                            }
                        }
                        return style;
                    }
                    col.fn = function(i,c,rs,value){ //行的显示样式.
                        if(rs["fun_res_code"]){
                            subfindex = Ext.lt.cloneobj(rs["fun_res_code"]);
                            var seq = showMidleName(subfindex,"fun_res_code");
                            if(i==seq){
                                return value;
                            }
                            return "";
                        }
                    }
                }
                if(col["colcode"] == "findex"){ //一级
                    var sindex = "";
                    var subsindex = "";
                    col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                        if(j==2){
                            var tabledata = indexprodatatable.getRecordSet().toArray();
                            var statnum = 0;
                            if(i==statnum){
                                sindex = Ext.lt.cloneobj(rs["findex"]);
                            }
                            if(sindex == rs["findex"]){
                                style ='style="border-bottom-style:none;text-align:center;';//position:relative;padding-top:5px;
                            } else {
                                style ='style="border-top-width:1px;text-align:center;border-top-color:#cccccc;border-bottom-style:none;';
                            }
                            sindex = Ext.lt.cloneobj(rs["findex"]);
                            if(i == tabledata.length-1){
                                style =style +'border-bottom-style:solid;"';
                            } else {
                                style =style + '"';
                            }
                            /*if(indexdatatable.uiconfig.totaltag ==1 && i==0){ //有权重的合计
                                style ='style="border-bottom-style:none;text-align:center;"';//position:relative;padding-top:5px;
                            }*/
                        }
                        return style;
                    }
                    col.fn = function(i,c,rs,value){ //行的显示样式.
                        if(rs["findex"]){
                            subsindex = Ext.lt.cloneobj(rs["findex"]);
                            var seq = showMidleName(subsindex,"findex");
                            if(i==seq){
                                return value;
                            }
                            return "";
                        }
                    }
                }

			}
        }
    });


    function amtTotal(table) {
        var totalrow = table.getRecordset();
        var sumamt = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                var score = rowarr[i]["score"] ? rowarr[i]["score"] : 0;
                sumamt += parseFloat(score);
            } else if (rowarr[i].isleaf == undefined && rowarr[i].levelno == undefined) {
                var score = rowarr[i]["score"] ? rowarr[i]["score"] : 0;
                sumamt += parseFloat(score);
            }
        }
        var totalrs = {};
        totalrs["score"] = sumamt == 0 ? "" : sumamt.toFixed(2);
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        }

    }

    /**
	 * 指标选中的项目信息.
     * @param indexguid.
	 * @param projs --项目guids
     */
    cmp.selpros = function(indexguid, projs){
        //indexprojects = JSON.parse(projs);
        indexprojects = projs;
        var params = {};
        var url = "/pmkpi/deptZJformance/report/edit/selpros.page";
        params.saveAgency = _saveAgency;
        params.mainguid = _mainguid;
        params.indexguid = indexguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth-80,_scrHeight-60,"部门预算项目或专项资金");
	}

    /**
	 *  处理预算挂钩机制涉及金额汇总.
     * @param col,那些列需要合计.
     */
    cmp.bgtamtTotal = function (col) {
		var totalrow = budgetdatatable.getRecordset();
		var sumamt = 0;
		var rowarr = totalrow.toArray();
		var len = rowarr.length;
		for ( var i = 0; i < len; i++) {
			if (rowarr[i].indexguid != "FIXEDBGTLINKBGTINFO0001" && rowarr[i].indexguid != "FIXEDBGTLINKBGTINFO0002") {
				var weight = rowarr[i][col] ? rowarr[i][col] : 0;
				sumamt += parseFloat(weight);
			}
		}
        var parent_sel_rows = budgetdatatable.getRecordset().query({indexguid:"FIXEDBGTLINKBGTINFO0002"});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        /*parent_sel_obj["projmod"] = 'mod'; //指标对应项目发生变动.
        parent.perfindexdatatable.reflash(_sortid);*/
        var colsumamt = sumamt == 0 ? "0.00" : sumamt.toFixed(2);
        budgetdatatable.updateData(_sortid,col,colsumamt);
    }


    /**
     * 指标表格填报数据的校验方法.
     * @returns {boolean}
     */
    cmp.checkAll = function() {
        var datas = perfindexdatatable.getRecordSet().toArray();
		var rowdata ={};
        var sumscore = 0;
        var score = 0;
        var backflg = true;
        for (var i = 0,leni = datas.length; i < leni; i++) {
            rowdata = datas[i];
            if (rowdata["findex"] == "4"){
                score = rowdata["score"] ? rowdata["score"] : 0;
                sumscore += parseFloat(score);
			}
            if (rowdata["kpi_val"].match(RegExp("[*_-]")) != null) {
                Ext.lt.ui.alert('第'+(i+1)+"行，指标值不符合规范，请重新填写！",function(){});
                backflg = false;
                break;
            }
			if (rowdata["computesign"] != "6" && (!rowdata["meterunit"] || rowdata["meterunit"] == "")){
                Ext.lt.ui.alert('第'+(i+1)+"行，定量指标请输入单位！",function(){
                });
                backflg = false;
				break;
			}
        }
        if (backflg == false){
        	return backflg;
		}
        if (sumscore != 100 && sumscore != 100.00){
            Ext.lt.ui.alert("产出与效果指标分值必须等于100分！",function(){
            });
            backflg = false;
		}
        return backflg;
    }

    /**
	 * 行级合并处理函数.
     * @param val
     * @param col
     * @returns {number}
     */
    showMidleName = function(val,col){
        var tabledata = indexprodatatable.getRecordSet().toArray();
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

    showMidleName2 = function(val){
        var tabledata = indexprodatatable.getRecordSet().toArray();
        var a = -1,b=-1;
        var atemp = {};
        for ( var i = 0; i < tabledata.length; i++) {
            atemp = tabledata[i];
            if(val == (atemp["sname"]+atemp["fun_res_code"])){
                a = atemp["_sortid"]; //首次出现值
                break;
            }
        }
        var btemp = {};
        for ( var i = tabledata.length-1; i >-1; i--) {
            btemp = tabledata[i];
            if(val == (atemp["sname"]+atemp["fun_res_code"])){
                b = btemp["_sortid"]; //结束出现值
                break;
            }
        }
        return parseInt((b-a)/2)+a;
    }

	return cmp;
}