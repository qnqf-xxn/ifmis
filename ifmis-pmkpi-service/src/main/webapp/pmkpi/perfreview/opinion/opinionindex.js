if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.review){
    Ext.lt.pmkpi.review = {};
}

Ext.lt.pmkpi.review.opinionservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var datas = config.datas;
    var _tabcomps = datas.indexdata;
    var _editinfo = datas.editinfo;
    var _showtab = config.showtab;
    var _proguid = config.proguid;
    var _mainguid = config.mainguid;
    var _frametype = config.frametype;
    var _prolev = config.prolev;
    var _procode = config.procode;
    var _viewtype = config.viewtyoe;
    var _bustype = config.bustype;
    var _curtab = "total";
    var tabnum = 0; //页签点击次数
    var _cmp = {};
    //页面加载完成后执行
    $(function() {
        if (_bustype == "program" || _bustype == "zyzfprogram"){
            _cmp.bulidTopHead();
        }
        if (_bustype == "dept" || _showtab == "3"){ //处理年度显示的时候
            _curtab = "year";
            _showtab = "3";
        }
        var tempdata = _tabcomps["#"+_curtab];
        datatable.setDatas(tempdata);
        if (_editinfo) {
            editform.synchEditformByObj(_editinfo);
        }
        if (_viewtype == "query") {
            common.editSetdisabled(editform);
        }
        _cmp.setTableColum();
        parent._isQuery = true;
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
        if (_showtab == 3){
            _curtab = "year";
        }
        if(tabnum != 0  && _curtab != obj.code && _showtab != 3){
            var num = 1;
            if (_curtab == "total"){
                num = 0;
            }
            if (!_cmp.checkAll()) {
                tabpage.doActiveTab(num);
                return;//先校验
            }
            var tempdata =  datatable.getRecordSet().toArray();
            if (obj.code == "year"){
                _tabcomps["#total"] =Ext.lt.cloneobj(tempdata);
            } else {
                _tabcomps["#year"] =Ext.lt.cloneobj(tempdata);
            }
            var tempdata = _tabcomps["#"+obj.code];
            datatable.setDatas(tempdata);
        }
        _curtab = obj.code;
        tabnum ++;
        // Ext.lt.message.send("datatable", 'beforesetcols', {
        //     table: datatable,
        //     cols: _prjindexcoldatas
        // });
    }

    /**
     * 页面初始化.
     */
    _cmp.init = function(){
        var params = {};
        params.proguid = _proguid;
        params.showtab = _showtab;
        params.prolev = _prolev;
        params.frametype = _frametype;
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service, "findAllIndex", [params], function(data) {
            _tabcomps = data.indexdata;
            _tabcomps["del#total"] = []; //总体删除
            _tabcomps["del#year"] = []; //年度删除
            var tempdata = _tabcomps["#"+_curtab];
            datatable.setDatas(tempdata);
            editform.synchEditformByObj(data.editinfo);
            Ext.lt.ui.loadingClose();
        })
    }

    /**
     * 保存方法.
     */
    _cmp.save = function(obj){
        if (!_cmp.checkAll()) return;//先校验
        if (!editform.check()) return;
        //保存之前存放当前最后一次
        var editdatas = editform.getEditFormValues();
        var tempdata =  datatable.getAllData();
        _tabcomps["#"+_curtab] =Ext.lt.cloneobj(tempdata);
        var params = {};
        params.proguid = _proguid;
        params.datas = _tabcomps;
        params.prolev = _prolev;//项目级别 123
        params.showtab = _showtab; //展示的目标数
        params.editdatas = editdatas;
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if(rs && rs.success){
            _cmp.init();
        }
        return rs;
    }

    /**
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++) {
            var col = cols[i];
            if (_viewtype == 'query') {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            } else {
                //一二级指标不可修改
                if (col["colcode"] == "opinion_remark") {
                    col.oneditstart = function (table, el, l, c, d) {
                        if (d.levelno != "3") {
                            return false;
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

    var _displaycols = [];
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
            if (col.colcode == "obligate1") {
                _displaycols.push(col); //隐藏前暂存至sfagency;
                col.display = false; //display置为false，隐藏
            }
            if (col.colcode == "opinion_remark") {
                col.edit = true;
            } else {
                col.edit = false;
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.levelno != 3){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });
    return _cmp;
}