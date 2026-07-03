if (!Ext.lt.pmkpitreetabs) Ext.lt.pmkpitreetabs = {};
if (!Ext.lt.pmkpitreetabs.layout) Ext.lt.pmkpitreetabs.layout = {};

Ext.lt.pmkpitreetabs.layout.index = function(config, service) {
	var _cmp={};
	var tpl=Ext.lt.pmkpitreetabs.layout;
	_cmp = Ext.lt.apply({syname:"layout_"}, _cmp);
	_cmp.resize=function(w,h){
		var layout = this.layout ;
		if(!!!layout) {
			return;
		}
		var comps=layout.main;
		var mainids = layout.mainids;
		el=layout.el;
		var maindiv = layout.maindiv;
		var mh = null;
		mh = el.offsetHeight;
		var mw = el.offsetWidth-2;
		maindiv.style.height = mh+"px";
		maindiv.style.width = mw+"px";
		var autoComps = layout.autoComps;
		if(comps!=null){
			if(!Ext.lt.isArray(comps))comps=[comps];
			if(!Ext.lt.isArray(mainids))mainids=[mainids];
			var els=maindiv.childNodes;
			var h=maindiv.offsetHeight;
			var w=maindiv.offsetWidth-(Ext.lt.ui.isScrollY(maindiv)?20:0);
			for(var i=0,j = comps.length; i <j; i++){
				if(typeof(comps[i])!="string"){
					try{
						comps[i].resize(w, els[i].offsetHeight);
					}catch(err){
						debugger;
					}
				}
			}
			if(autoComps.length>0){
				var userHeight = 0;
				for(var i=0,j = els.length; i <j; i++){
					var isauto = false;
					for(var k=0;k<autoComps.length;k++){
						if(i==autoComps[k]){
							isauto = true;
							break;
						}
					}
					if(!isauto){
						if(els[i].style.display!='none'){
							var elH = els[i].offsetHeight+fixHeight(els[i]);
							if(els[i].className!=null && els[i].className.indexOf("busnomalbtn_outline")!=-1){//由于操作栏用margin-top:8px;
								elH+=8;
							}
							userHeight += elH;	
						}				
					}
				}
				var freeHeight = mh-userHeight-2;
				var autoCompsH = Math.floor(freeHeight/autoComps.length)-2;//2:表格margin-top:2px;
				if(autoCompsH<100)autoCompsH = 100;
				for(var k=0;k<autoComps.length;k++){
					var i = autoComps[k];
					els[i].style.height = autoCompsH+'px';
					eval(comps[autoComps[k]]).resize(w,autoCompsH-15);	
				}
			}
		}		
	};
	
	
	_cmp.draw=function(el){
		var layout = this.layout;
		var html=[];
		if(!!!layout) {
			return;
		}
		var comps=layout.main;
		var mainids=layout.mainids;
		layout.el=el;
		if(el.offsetWidth<400){
			w=400
		}else{
			w=el.offsetWidth;
		}
		var maindiv = null;
		maindiv = el;
		if(comps!=null){
			if(!Ext.lt.isArray(comps))comps=[comps];
			if(!Ext.lt.isArray(mainids))mainids=[mainids];
			var autoh=200;			
			var mh = el.offsetHeight;			
			maindiv.style.height = (mh)+"px";
			maindiv.style.width = w+"px";
			html=[];
			var autoComps =[];			
			for(var i=0,j = mainids.length; i <j; i++){
				var id = mainids[i] ;
				if(id.indexOf("datatable")!=-1||id.indexOf("service")!=-1){
					autoComps[autoComps.length] = i;
				}
				if(id.indexOf("tabpage")!=-1){
					html.push('<div id="',(id+"tabs"+i),'" style="width:',w,'px;height:35px"></div>');
				}else if(id.indexOf("toolbutton")!=-1){
					html.push('<div id="',(id+"tabs"+i),'" style="width:',w,'px;height:30px"></div>');
				}else if(id.indexOf("titleeditform")!=-1&&typeof(comps[i])=="string"){
					html.push("<div id = 'titlediv' style='width:",w,"px;height:25px;margin-left:0px' class='busefitformpanel propj_editform'></div>");
				}else{
					html.push('<div id="',(id+"tabs"+i),'" style="width:',w,'px;"></div>');
				}
			}
			layout.autoComps = autoComps;
			maindiv.innerHTML = html.join('');
			layout.maindiv=maindiv;			
			var cn=maindiv.childNodes;
			for(var i=0,j = mainids.length; i <j; i++){
				var comp = comps[i] ;				
				if(typeof(comp)!="string"){
					comp.draw(cn[i]);
				}else{
					cn[i].innerHTML = createTitle(w); 
				}
				cn[i].setAttribute("compid", mainids[i]);
			}
			if(autoComps.length>0){	
				var userHeight = 0;
				for(var i=0,j = cn.length; i <j; i++){
					var isauto = false;
					for(var k=0;k<autoComps.length;k++){
						if(i==autoComps[k]){
							isauto = true;
							break;
						}
					}					
					if(cn[i].style.display!='none'){
						var elH = cn[i].offsetHeight+fixHeight(cn[i]);
						if(cn[i].className!=null && cn[i].className.indexOf("busnomalbtn_outline")!=-1){//由于操作栏用margin-top:8px;
							elH+=8;
						}
						userHeight += elH;	
					}	
				}
				var freeHeight = mh-userHeight-2;
				var autoCompsH = Math.floor(freeHeight/autoComps.length)-2;//2:表格margin-top:2px;
				if(autoCompsH<100)autoCompsH = 100;
				for(var k=0;k<autoComps.length;k++){
					var i = autoComps[k];
					cn[i].style.height = autoCompsH+'px';
					cn[i].setAttribute("_height", "auto");
					cn[i].setAttribute("compid", mainids[i]);
				}
			}
			_cmp.layout = layout;
		}
	}

	_cmp.redarw = function (el){
		if(el==null){
			var tpl_right=$(".tpl_right");
			if(tpl_right&&!!tpl_right[0]){
				el = tpl_right[0];
			}else {
				var bd_main  = $(".bd_main");
				if(bd_main&&!!bd_main[0]){
					el = bd_main[0];
				}
			}
			el.style.overflowX = "hidden";
			el.style.overflowY = "auto";
		}	
		var createDiv  = document.getElementById("treetabs");
		if(!!!createDiv){
			createDiv =document.createElement("div");
			createDiv.id = "treetabs";			
			var html=[];
			html.push('<div id="treetabs" ></div>');
			createDiv.innerHTML = html.join("").replace(/\t/g,"");
			el.appendChild(createDiv);
			sumHeight(createDiv);
		}else{
			var cn= createDiv.childNodes;		
			if(cn!=null&&cn.length>0){
				var len = cn.length;
				for(var int = len-1;int>=0;int--){
					createDiv.removeChild(cn[int]);
				}
			}
		}		
		return createDiv;		
	}
	
	function sumHeight(el){
		var mainDiv = el.parentNode
		el.style.width = mainDiv.offsetWidth+"px";
		var h = 0;
		var cn= mainDiv.childNodes;		
		if(cn!=null&&cn.length>0){
			var len = cn.length;
			for(var int = len-1;int>=0;int--){
				if(cn[int].id!=el.id){
					h = mainDiv.offsetHeight - cn[int].offsetHeight;
				}
			}
		}
		el.style.height = (h>5?h-5:h) +"px";
	}
	
	Ext.lt.message.hook("layout", "endlayout2",function(params){
		var el  = document.getElementById("treetabs");
		if(el){
			sumHeight(el);
			_cmp.resize(el.offsetWidth,el.offsetHeight);
			
			var titlediv  = document.getElementById("titlediv");
			if(titlediv){
				titlediv.style.width = el.offsetWidth+"px";
			}
			
			Ext.lt.message.send("layout", "endlayout3",{});		
		}
		
	});
	
	_cmp.reDarwTabs = function(tabs,obj){
		el = _cmp.redarw();
		var  tablists = Ext.lt.RCP.asynserver("pmkpi.PmkpiTreeTabsLayoutService", "findTabs", {tabs:tabs});
		var comps = [];
		_cmp.years = [];
		var tableCode = obj.tableCode;
		var busIsHidden = obj.busIsHidden;
		var meatype = obj.meatype;
		var hiddenEdit = false;
		var projtype = obj.projtype;
		_cmp.xmzcjjflyears = obj.xmzcjjflyears;
		_cmp.year = obj.year;//默认选择的年度
		_cmp.jxmblx   = false;
		_cmp.jxmblxvalue   = obj.jxmblxvalue;
		_cmp.yearchangekey  = obj.yearchangekey; //切换年度是否切换key
		if(tablists!=null&&tablists.length>0){			
			var layout = {};
			var main = [];
			var mainids = [];
			for(var int =0 ; int < tablists.length; int++){
				var uitab = tablists[int];
				var componentconfig = uitab["componentconfig"];
				eval("var uiconfig = "+componentconfig+"||{}");				
				if(_cmp.jxmblx){
					var tab = uiconfig.tab;
					if(((!!!_cmp.jxmblxvalue||_cmp.jxmblxvalue=="0")&&tab==2)||(!!_cmp.jxmblxvalue&&_cmp.jxmblxvalue=="1"&&tab==1)){
						continue;
					}
				}
				var componentid = uitab["componentid"];
				var componenttype = uitab["componenttype"];				
				var componentfunction = uitab["componentfunction"];	
				if(componenttype=="6"){	
					_cmp.years = obj.years;
					_cmp.year = obj.year;
					_cmp.jxmblx   = uiconfig.jxmblx;
					main.push(componentid);
					mainids.push(componentid);
				}else if(componenttype!="11"){		
					var editObj = _cmp.getComponent(uitab,uiconfig,componentid,componenttype,componentfunction,tableCode);
					if((busIsHidden == 1 || busIsHidden == 2) && uitab.componenttype == '2'){
						var tableid = editObj.id;
						var newDatas= ["_locationposition","check"];
						var columns = editObj.uiconfig.columns;
						
//						for(var j=0;j<columns.length;j++){
//							if(meatype == 'JXLX01' || meatype == 'JXLX02'){ //  || columns[j].colcode == "scoringrules"
//								if(columns[j].colcode == "measuresweight"){
//									continue;
//								}
//							}else if(meatype == 'JXLX03' || meatype == 'JXLX04'){
//								if(columns[j].colcode == "referencepole"){
//									continue;
//								}
//							}
//							if(tabs !="PSJL01"){
//								if(columns[j].alias != "操作"){
//									newDatas.push(columns[j].colcode);
//								}
//							}else{
//								newDatas.push(columns[j].colcode);
//							}
//						}
//						Ext.lt.cache.setData('dtcolumn_'+tableid,Object.toJSON(newDatas));
						

						var hiddens = [];
						for (var j = 0; j < columns.length; j++) {
							if (columns[j].isvisiable == "0" || columns[j].alias == "操作") {
								hiddens.push(columns[j].colcode);
							}
						}
						editObj.setHiddenColumn(hiddens);
						
					}else if((meatype == 'JXLX01' || meatype == 'JXLX02') && uitab.componenttype == '2'){
						var tableid = editObj.id;
						var newDatas= ["_locationposition","check"];
						var columns = editObj.uiconfig.columns;
						for(var j=0;j<columns.length;j++){
							if(columns[j].colcode == "measuresweight"){//  || columns[j].colcode == "scoringrules"
								continue;
							}
							newDatas.push(columns[j].colcode);
						}
						Ext.lt.cache.setData('dtcolumn_'+tableid,Object.toJSON(newDatas));
					}else if((meatype == 'JXLX03' || meatype == 'JXLX04') && uitab.componenttype == '2'){
						var tableid = editObj.id;
						var newDatas= ["_locationposition","check"];
						var columns = editObj.uiconfig.columns;
						for(var j=0;j<columns.length;j++){
							if(columns[j].colcode == "referencepole"){
								continue;
							}
							newDatas.push(columns[j].colcode);
						}
						Ext.lt.cache.setData('dtcolumn_'+tableid,Object.toJSON(newDatas));
					}else if(uitab.componenttype == '2'){
						var tableid = editObj.id;
						Ext.lt.cache.removeData('dtcolumn_'+tableid);
//						var tableid = editObj.id;
						var newDatas= ["_locationposition","check"];
						var columns = editObj.uiconfig.columns;
						
						var projtype = obj.projtype;
						for(var j=0;j<columns.length;j++){
						if(projtype == '3' || projtype == '4'){
							if(columns[j].colcode == "vcol3"){
								continue;
							}
						}
						if(projtype == '1' || projtype == '2'){
							if(columns[j].colcode == "vcol5"){
								continue;
							}
						}
							newDatas.push(columns[j].colcode);
						}
						Ext.lt.cache.setData('dtcolumn_'+tableid,Object.toJSON(newDatas));
					}else if(uitab.componenttype == '1'){
						var tableid = editObj.id;
						var newDatas= ["_locationposition","check"];
						var columns = editObj.cfg.data;
						if(projtype == '3' || projtype == '4'){
							for(var i = 0; i < columns.length; i++) {
								if(columns[i].colcode.toLowerCase() == "longtermgoal") {
									editObj.cfg.data.splice(i, 1);
									hiddenEdit = true;
								}
							} 
						}
					}
					obj[componentid] = editObj;
					if(!!!uiconfig.iswindow){
						main.push(editObj);
						mainids.push(componentid);						
					}				
				}
				
			}
			
			layout.main = main;
			layout.mainids = mainids;
			_cmp.layout = layout;
			_cmp.draw(el);
			if(componenttype=="11"){
				var formMap = Ext.lt.RCP.asynserver("pmkpi.PmkpiTreeTabsLayoutService", "findForm", {formid:obj.tableguid});
//				var html = '<div  style="overflow:auto;"><table width="784" align="center" cellspacing="0" cellpadding="0"><colgroup><col width="89" style="width: 89px;"/><col width="424" style="width: 424px;"/><col width="87" style="width: 87px;"/><col width="184" style="width: 184px;"/></colgroup><tbody><tr height="52" class="firstRow" style="height: 52px;"><td width="784" height="52" align="center" valign="middle" style="border: 0px black; border-image: none; background-color: transparent;" colspan="4"><strong><span style="font-family: 宋体;"><span style="font-size: 24px;">贵阳市人大预算绩效管理工作推进情况统计表<br/></span><span style="font-size: 24px;"> &nbsp; &nbsp; （截至2018年底工作情况）</span></span></strong></td></tr><tr height="37" style="height: 37px;"><td width="784" height="37" style="border-width: 0px 0px 1px; border-style: none none solid; border-color: black black windowtext; background-color: transparent;" colspan="4"><strong><span style="font-family: 宋体;">一、基础工作</span></strong></td></tr><tr height="34" style="height: 35px;"><td width="89" height="35" align="center" valign="middle" style="border-width: 0px 1px 1px; border-style: none solid solid; border-color: black windowtext windowtext; background-color: transparent;"><strong><span style="font-family: 宋体;">类别</span></strong></td><td width="424" align="center" valign="middle" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><strong><span style="font-family: 宋体;">项目</span></strong></td><td width="87" align="center" valign="middle" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><strong><span style="font-family: 宋体;">内容</span></strong></td><td width="184" align="center" valign="middle" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><strong><span style="font-family: 宋体;">备注</span></strong></td></tr><tr height="26" style="height: 27px;"><td width="89" height="188" style="border-width: 0px 1px 1px; border-style: none solid solid; border-color: black windowtext; background-color: transparent;" rowspan="7"><span style="font-family: 宋体;">工作推进</span></td><td width="424" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">部门本级是否已开展预算绩效管理</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;"><span plugins="select"><select name="data_1" title="是否" style="width: 83px;" size="1" tablename="PMKPI_T_WPBASEINFO" fieldname="VCOL1" orgwidth="80" fieldflow="0" plugins="select"><option selected="selected" value="是">是</option><option value="否">否</option></select></span></span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">部门所属下级（二级）预算单位数量<span style="font-size: 12px;"><sup>①</sup></span>（个）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;"><input name="data_2" title="2" style="width: 80px; text-align: left;" type="text" value="" tablename="PMKPI_T_WPBASEINFO" fieldname="VCOL2" orgalign="left" orgwidth="80" orghide="0" fieldflow="0" plugins="text" orgtype="text"/></span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">其中：已开展预算绩效管理的单位数量（个）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;"><input name="data_3" title="3" style="width: 80px; text-align: left;" type="text" value="" tablename="PMKPI_T_WPBASEINFO" fieldname="VCOL3" orgalign="left" orgwidth="80" orghide="0" fieldflow="0" plugins="text" orgtype="text"/></span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">&nbsp; &nbsp; 占本部门全部二级预算单位的比重（%）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;"><input name="data_4" title="4" style="width: 80px; text-align: left;" type="text" value="" tablename="PMKPI_T_WPBASEINFO" fieldname="VCOL4" orgalign="left" orgwidth="80" orghide="0" fieldflow="0" plugins="text" orgtype="text"/></span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">7</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">其中：已开展预算绩效管理的单位数量（个）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">40</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">&nbsp; &nbsp; 占本部门全部三级及以下预算单位的比重（%）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">30</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="89" height="169" style="border-width: 0px 1px 1px; border-style: none solid solid; border-color: black windowtext; background-color: transparent;" rowspan="6"><span style="font-family: 宋体;">组织机构</span></td><td width="424" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">本部门预算绩效管理主管处室名称</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">绩效管理处</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">编制人数（人）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">5</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">实际从事预算绩效管理工作人数（人）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">4</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是否成立正式预算绩效管理工作领导小组（是/否）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">小组组长</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">办公厅领导</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处填写姓名和职务</span></td></tr><tr height="34" style="height: 35px;"><td width="424" height="35" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">小组成员</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">2</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处填写具体单位名称</span></td></tr><tr height="26" style="height: 27px;"><td width="89" height="80" style="border-width: 0px 1px; border-style: none solid; border-color: black windowtext; background-color: transparent;" rowspan="3"><span style="font-family: 宋体;">规章制度</span></td><td width="424" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">已出台的部门预算绩效管理顶层制度<span style="font-size: 12px;"><sup>②</sup></span>数量（个）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">3</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处列明文件名称及文号</span></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">已出台的部门预算绩效管理具体办法<span style="font-size: 12px;"><sup>③</sup></span>数量（个）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">1</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处列明文件名称及文号</span></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">已出台的部门预算绩效管理操作细则<span style="font-size: 12px;"><sup>④</sup></span>数量（个）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">2</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处列明文件名称及文号</span></td></tr><tr height="26" style="height: 27px;"><td width="89" height="107" style="border: 1px solid windowtext; border-image: none; background-color: transparent;" rowspan="4"><span style="font-family: 宋体;">智库建设</span></td><td width="424" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是否建立部门专家学者库（是/否）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">在库专家学者人数（人）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">3</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是否建立部门中介机构库（是/否）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">在库中介机构家数（个）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">7</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="89" height="62" style="border-width: 0px 1px 1px; border-style: none solid solid; border-color: black windowtext windowtext; background-color: transparent;" rowspan="2"><span style="font-family: 宋体;">指标体系</span></td><td width="424" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是否建立本部门绩效指标体系（是/否）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">是</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="34" style="height: 35px;"><td width="424" height="35" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">绩效指标体系数量（项）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">15</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处列明指标体系分类名称，具体可另附相关材料</span></td></tr><tr height="34" style="height: 35px;"><td width="89" height="150" style="border-width: 0px 1px 1px; border-style: none solid solid; border-color: black windowtext; background-color: transparent;" rowspan="5"><span style="font-family: 宋体;">宣传培训</span></td><td width="424" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">部门当年发表的预算绩效管理宣传文章、报道等数量（篇）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">1</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处列明文章和报道的发表时间和题目</span></td></tr><tr height="34" style="height: 35px;"><td width="424" height="35" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">部门当年开展的预算绩效管理培训次数（次）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">3</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">请在此处列明《培训通知》文件名称和文号</span></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">培训对象</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">内部</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">培训人次（人）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体; font-size: 12px;">50</span></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr><tr height="26" style="height: 27px;"><td width="424" height="27" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"><span style="font-family: 宋体;">部门当年上报财政部的预算绩效管理信息、动态等（篇）</span></td><td width="87" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td><td width="184" style="border-width: 0px 1px 1px 0px; border-style: none solid solid none; border-color: black windowtext windowtext black; background-color: transparent;"></td></tr></tbody></table><p></p></div>';
				var html = "<div id='formHtml' style='overflow:auto;'>"+formMap.originalhtml+"</div>";
				$("div[id='treetabs']").append(html);
			}
			_cmp.resize(el.offsetWidth,el.offsetHeight);
			if(hiddenEdit){
				var _panel = editObj;
				var hideElements = ["longtermgoal"];
				if (hideElements) {
					_panel.hide(hideElements);
				}
			}
			return true;
		}	
		return false;
	}
	
	/**
	 * 特殊页面画表格方法
	 * (重点评价-绩效评价报告页面用)
	 * @param tabs
	 * @param obj
	 * @returns {Boolean}
	 */
	_cmp.reDarwTabsSpecial = function(tabs,obj){
		el = _cmp.redarw();
		var  tablists = Ext.lt.RCP.asynserver("pmkpi.PmkpiTreeTabsLayoutService", "findTabs", {tabs:tabs});
		var comps = [];
		_cmp.years = [];
		var tableCode = obj.tableCode;
		_cmp.xmzcjjflyears = obj.xmzcjjflyears;
		_cmp.year = obj.year;//默认选择的年度
		_cmp.jxmblx   = false;
		_cmp.jxmblxvalue   = obj.jxmblxvalue;
		_cmp.yearchangekey  = obj.yearchangekey; //切换年度是否切换key
		if(tablists!=null&&tablists.length>0){			
			var layout = {};
			var main = [];
			var mainids = [];
			for(var int =0 ; int < tablists.length; int++){
				var uitab = tablists[int];
				var componentconfig = uitab["componentconfig"];
				eval("var uiconfig = "+componentconfig+"||{}");				
				if(_cmp.jxmblx){
					var tab = uiconfig.tab;
					if(((!!!_cmp.jxmblxvalue||_cmp.jxmblxvalue=="0")&&tab==2)||(!!_cmp.jxmblxvalue&&_cmp.jxmblxvalue=="1"&&tab==1)){
						continue;
					}
				}
				var componentid = uitab["componentid"];
				var componenttype = uitab["componenttype"];				
				var componentfunction = uitab["componentfunction"];	
				if(componenttype=="6"){	
					_cmp.years = obj.years;
					_cmp.year = obj.year;
					_cmp.jxmblx   = uiconfig.jxmblx;
					main.push(componentid);
					mainids.push(componentid);
				}else{					
					var editObj = _cmp.getComponent(uitab,uiconfig,componentid,componenttype,componentfunction,tableCode);
					obj[componentid] = editObj;
					if(!!!uiconfig.iswindow){
						main.push(editObj);
						mainids.push(componentid);						
					}				
				}
				
			}

			layout.main = main;
			layout.mainids = mainids;
			_cmp.layout = layout;
			_cmp.drawSpecial(el);
			_cmp.resize(el.offsetWidth,el.offsetHeight);
			return true;
		}	
		return false;
	}
	
	/**
	 * 特殊页面画表格方法 
	 * (重点评价-绩效评价报告页面用)
	 * @param el
	 */
	_cmp.drawSpecial=function(el){
		var layout = this.layout;
		var html=[];
		if(!!!layout) {
			return;
		}
		var comps=layout.main;
		var mainids=layout.mainids;
		layout.el=el;
		if(el.offsetWidth<400){
			w=400
		}else{
			w=el.offsetWidth;
		}
		var maindiv = null;
		maindiv = el;
		if(comps!=null){
			if(!Ext.lt.isArray(comps))comps=[comps];
			if(!Ext.lt.isArray(mainids))mainids=[mainids];
			var autoh=200;			
			var mh = el.offsetHeight;			
			maindiv.style.height = (mh)+"px";
			maindiv.style.width = w+"px";
			html=[];
			var autoComps =[];			
			for(var i=0,j = mainids.length; i <j; i++){
				var id = mainids[i] ;
				if(id.indexOf("datatable")!=-1||id.indexOf("service")!=-1){
					autoComps[autoComps.length] = i;
				}
				if(id.indexOf("tabpage")!=-1){
					html.push('<div id="',(id+"tabs"+i),'" style="width:',w,'px;height:35px"></div>');
				}else if(id.indexOf("toolbutton")!=-1){
					html.push('<div id="',(id+"tabs"+i),'" style="width:',w,'px;height:30px"></div>');
				}else if(id.indexOf("titleeditform")!=-1&&typeof(comps[i])=="string"){
					html.push("<div id = 'titlediv' style='width:",w,"px;height:25px;margin-left:0px' class='busefitformpanel propj_editform'></div>");
				}
			}
			html.push(Ext.lt.pmkpitreetabs.layout.createReportBody());
			
			layout.autoComps = autoComps;
			maindiv.innerHTML = html.join('');
			layout.maindiv=maindiv;			
			var cn=maindiv.childNodes;
			for(var i=0,j = mainids.length; i <j; i++){
				var comp = comps[i] ;				
				if(typeof(comp)!="string"){
					comp.draw(cn[i]);
				}else{
					cn[i].innerHTML = createTitle(w); 
				}
				cn[i].setAttribute("compid", mainids[i]);
			}
			if(autoComps.length>0){	
				var userHeight = 0;
				for(var i=0,j = cn.length; i <j; i++){
					var isauto = false;
					for(var k=0;k<autoComps.length;k++){
						if(i==autoComps[k]){
							isauto = true;
							break;
						}
					}					
					if(cn[i].style.display!='none'){
						var elH = cn[i].offsetHeight+fixHeight(cn[i]);
						if(cn[i].className!=null && cn[i].className.indexOf("busnomalbtn_outline")!=-1){//由于操作栏用margin-top:8px;
							elH+=8;
						}
						userHeight += elH;	
					}	
				}
				var freeHeight = mh-userHeight-2;
				var autoCompsH = Math.floor(freeHeight/autoComps.length)-2;//2:表格margin-top:2px;
				if(autoCompsH<100)autoCompsH = 100;
				for(var k=0;k<autoComps.length;k++){
					var i = autoComps[k];
					cn[i].style.height = autoCompsH+'px';
					cn[i].setAttribute("_height", "auto");
					cn[i].setAttribute("compid", mainids[i]);
				}
			}
			_cmp.layout = layout;
		}
	}
	
	_cmp.getComponent = function(uitab,uiconfig,componentid,componenttype,componentfunction,tableCode){
		var componentkey = uitab["componentkey"];
		var componentserviceid = uitab["componentserviceid"];
		uiconfig.id = componentid;
		uiconfig.key = componentkey;
		var tempconfig = null;
		if(_cmp.yearchangekey&&componenttype=="1"){
			uiconfig.key = uiconfig.key +"_"+ _cmp.year ;
			tempconfig = Ext.lt.RCP.asynserver("buscommon.ui.editform", "getComponentConfig", uiconfig);
		}
		if(!!!tempconfig||(tempconfig&&tempconfig.data.length==0)){
			uiconfig.key = componentkey;
			tempconfig = Ext.lt.RCP.asynserver(componentserviceid, "getComponentConfig", uiconfig);
		}
//		if(_cmp.yearchangekey&&componenttype=="1"){
//			uiconfig.key = uiconfig.key +"_"+ _cmp.year ;
//			tempconfig = Ext.lt.RCP.asynserver("buscommon.ui.editform", "getComponentConfig", uiconfig);
//			if(tempconfig.data.length==0){
//				 uiconfig.key = componentkey;
//				 tempconfig = Ext.lt.RCP.asynserver("buscommon.ui.editform", "getComponentConfig", uiconfig);
//			}
//		}else{
//			tempconfig = Ext.lt.RCP.asynserver(componentserviceid, "getComponentConfig", uiconfig);
//		}
		var editObj = null;
		if(componenttype=="1"){	
			editObj = new Ext.lt.bus.ui.editformpanel(tempconfig,"/pmkpi/buscommon/ui/tabpage/uilist/editform");
		}else if(componenttype=="2"){
			editObj = new Ext.lt.bus.ui.datatable(tempconfig,"/pmkpi/buscommon/ui/tabpage/uilist/datatable");
		}else if(componenttype=="3"){
			editObj = new Ext.lt.bus.ui.toolbuttonbar(tempconfig);			
		}else if(componenttype=="4"){
			editObj = new Ext.lt.bus.ui.querypanel(tempconfig);
		}else if(componenttype=="5"){
			editObj = new Ext.lt.budget.jxgl.editformpanel(tempconfig);
		}else if(componenttype=="7"){
			editObj = new Ext.lt.bus.ui.editformpanelgz(tempconfig,"/pmkpi/buscommon/ui/tabpage/uilist/editform");
		}else if(componenttype=="8"){//自定义组件		
			if (!!componentfunction&&Ext.lt.isFunction(eval(componentfunction))) {
				componentfunction = eval(componentfunction);
			}
			editObj =new componentfunction(tempconfig,componentkey);
		}else if(componenttype=="9"){
			var xmzcjjflyears = _cmp.xmzcjjflyears;
			if(xmzcjjflyears&&xmzcjjflyears.length>0){
				var newdatas = [];
				for(var l=0,j=0;l<xmzcjjflyears.length&&j<tempconfig.data.length;l++,j++){
					var _data = tempconfig.data[l];
					_data.name = xmzcjjflyears[l];
					_data.title = xmzcjjflyears[l];
					newdatas.push(_data);
				}
				tempconfig.data = newdatas;
			}
			editObj = new Ext.lt.tabpanelbutton(tempconfig);
		}else if(componenttype=="10"){
			var uicomponent_path = _APPID_PATH_ +"/buscommon/ui/tabpage/uilist/";
			uiconfig.tableCode = tableCode;
			tempconfig = Ext.lt.RCP.asynserver("datacommon.dcdatatable", "getComponentConfig", uiconfig);
			var service = uicomponent_path+"dcdatatable";
			var dcdatatable = new Ext.lt.dc.fill.dcdatatable(tempconfig,service);
			info_load.viewcomponent["uidatatable"] = dcdatatable;
			return dcdatatable;
		}
		return editObj;
	}

	function createTitle(w){
		 var html = [];
		 html.push("	<div class='containerDiv'>");		
		 html.push("		<div calss='conditionDiv'>");
		 if(!!_cmp.jxmblx){
			 html.push("			<label>绩效目标类型：</label>");
			 html.push("			<span><select name='绩效目标类型' id='jxmblx' onchange = 'changeJxmblx(this.options[this.options.selectedIndex].value)'>");
			 
			 html.push("<option value='0' ");
			 if(!!!_cmp.jxmblxvalue||(!!_cmp.jxmblxvalue&&_cmp.jxmblxvalue=="0")){
					html.push(" selected = 'selected' ");
			 }	
			 html.push(">一般性项目</option>");
			 
			 html.push("<option value='1' ");
			 if(!!_cmp.jxmblxvalue&&_cmp.jxmblxvalue=="1"){
					html.push(" selected = 'selected' ");
			 }	
			 html.push(">重点项目</option>");
			 html.push("</select> </span>");
		 }	
	    if(!!_cmp.year){
	    	html.push("			<label class ='year'>预算年份：</label>");
			html.push("			<span><select name='预算年份' id='jxmbyear' style='width:80px;' onchange = 'changeSnnf(this.options[this.options.selectedIndex].value)'>>");
			var years = _cmp.years ;
			for(var int=0;int<years.length;int++){
				html.push("<option value='"+years[int]+"' ");
				if(years[int]==_cmp.year ){
					html.push(" selected = 'selected' ");
				}	
				html.push(">"+years[int]+"</option>");
			}
			 html.push("</select> </span>");
	    }		 
		 if(!!_cmp.jxmblx){	
			 html.push('		<div id="sumtiltelab" class="title_input">');
			 if(!!_cmp.jxmblxvalue&&_cmp.jxmblxvalue=="1"){
				 html.push('			项目支出绩效目标审核表（重点项目）');
			 }else{
				 html.push('			项目支出绩效目标审核表（一般性项目）');
			 }
		 }
		 html.push("		</div>");	
		 html.push("		</div>");	
		 return html.join("").replace(/\t/g,"");	
	}
	
	return _cmp;
}


function getPadding(el) {
	var pt = parseInt(Ext.lt.HTML.getRealStyle(el).paddingTop, 10) || 0;
	var pb = parseInt(Ext.lt.HTML.getRealStyle(el).paddingBottom, 10) || 0;
	var pl = parseInt(Ext.lt.HTML.getRealStyle(el).paddingLeft, 10) || 0;
	var pr = parseInt(Ext.lt.HTML.getRealStyle(el).paddingRight, 10) || 0;
	return [pt, pr, pb, pl];
}

function getBorder(el) {
	var bt = parseInt(Ext.lt.HTML.getRealStyle(el).borderTopWidth, 10) || 0;
	var bb = parseInt(Ext.lt.HTML.getRealStyle(el).borderBottomWidth, 10) || 0;
	var bl = parseInt(Ext.lt.HTML.getRealStyle(el).borderLeftWidth, 10) || 0;
	var br = parseInt(Ext.lt.HTML.getRealStyle(el).borderRightWidth, 10) || 0;
	return [bt, br, bb, bl];
}

function fixHeight(el){
	var br = getBorder(el);
	var pb = getPadding(el);
	return br[0]+br[2]+pb[0]+pb[2];
}

/**
 * 重点评价项目绩效评价报告页面
 */
Ext.lt.pmkpitreetabs.layout.createReportBody = function(){
	var html = [];
	html.push('<div id="title" style="width:',w,'px;" class=" busefitformpanel" compid="editformsource">')
		//标题
		html.push('<div class="edittitle">');
			html.push('<div>绩效评价报告</div>');
		html.push('</div>');
		//正文
		html.push('<div class="containerDiv" id="keyRpt_containerDiv">');
			//guid
			html.push('<div class="conditionDiv" style="display: none;">');
				html.push('<div class="treeselect">');
					html.push('<label class="lab" style="width:130px;"><font class="character" title="主键ID">主键ID</font></label>');
					html.push('<div id="intree_1162" style="float:left;">');
						html.push('<input name="guid" id="input_guid" class="inputbox" type="text" maxlength="40/" disabled="" style="text-align: left; background-color: rgb(255, 255, 255);" />');
				    html.push('</div>');
				html.push('</div>');
			html.push('</div>');
			//一、基本概况
			html.push('<div class="conditionDiv">');
				html.push('<div class="treeselect">');
					html.push('<font style="font-weight:bold;font-size:16px;">一、基本概况</font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
					html.push('<textarea id="textarea_report10" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
			html.push('</div>');
			//二、绩效评价的组织实施情况
			html.push('<div class="conditionDiv">');
				html.push('<div class="treeselect">');
					html.push('<font style="font-weight:bold;font-size:16px;">二、绩效评价的组织实施情况</font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
					html.push('<textarea id="textarea_report20" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
			html.push('</div>');
			//三、绩效评价指标体系、评价标准和评价方法
			html.push('<div class="conditionDiv">');
				html.push('<div class="treeselect">');
					html.push('<font style="font-weight:bold;font-size:16px;">三、绩效评价指标体系、评价标准和评价方法<br/></font>');
					html.push('<font>&nbsp;&nbsp;&nbsp;&nbsp;（一）绩效评价指标体系及评价标准<br/></font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
					html.push('<textarea id="textarea_report31" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
				
				html.push('<div class="treeselect">');
				html.push('<font>&nbsp;&nbsp;&nbsp;&nbsp;（二）评价方法<br/></font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
				html.push('<textarea id="textarea_report32" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
			html.push('</div>');

			//四、绩效目标的实现程度
			html.push('<div class="conditionDiv">');
				html.push('<div class="treeselect">');
					html.push('<font style="font-weight:bold;font-size:16px;">四、绩效目标的实现程度<br/></font>');
					html.push('<font>&nbsp;&nbsp;&nbsp;&nbsp;（一）绩效目标实现程度<br/></font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
					html.push('<textarea id="textarea_report41" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
				
				html.push('<div class="treeselect">');
				html.push('<font>&nbsp;&nbsp;&nbsp;&nbsp;（二）资金使用及管理情况<br/></font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
				html.push('<textarea id="textarea_report42" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
			html.push('</div>');
			
			//五、存在问题及原因分析
			html.push('<div class="conditionDiv">');
				html.push('<div class="treeselect">');
					html.push('<font style="font-weight:bold;font-size:16px;">五、存在问题及原因分析</font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
					html.push('<textarea id="textarea_report50" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
			html.push('</div>');
			
			//六、评价结论及建议
			html.push('<div class="conditionDiv">');
				html.push('<div class="treeselect">');
					html.push('<font style="font-weight:bold;font-size:16px;">六、评价结论及建议<br/></font>');
					html.push('<font>&nbsp;&nbsp;&nbsp;&nbsp;（一）评价结论<br/></font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
					html.push('<textarea id="textarea_report61" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
				
				html.push('<div class="treeselect">');
				html.push('<font>&nbsp;&nbsp;&nbsp;&nbsp;（二）相关建议<br/></font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
				html.push('<textarea id="textarea_report62" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
			html.push('</div>');			
			
			//七、其他需要说明的问题
			html.push('<div class="conditionDiv">');
				html.push('<div class="treeselect">');
					html.push('<font style="font-weight:bold;font-size:16px;">七、其他需要说明的问题</font>');
				html.push('</div>');
				html.push('<div class="treeselect">');
					html.push('<textarea id="textarea_report70" name="projsurvey" class="inputbox2" style="height: 142px; width: 725px;" maxlength="2000" uniqueid="htmlelement1082"></textarea>');
				html.push('</div>');
			html.push('</div>');			
		html.push('</div>');
	html.push('</div>');
	return html.join("").replace(/\t/g,"");
}