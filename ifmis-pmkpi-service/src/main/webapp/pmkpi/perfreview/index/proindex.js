if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfreview){
    Ext.lt.pmkpi.perfreview = {};
}

var _curtab = ""; //当前页签.
var _proguid = "";
var _showtab = "";
var _bustype = "";
var serviceid;
var _tabtype = "";
Ext.lt.pmkpi.perfreview.proindexservice = function(config, service){
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    serviceid = service;
    var _indexdatas = config.indexdatas,
        _reviewnum = config.reviewnum,
        _editdatas = config.editdatas,
        _reviewdatas = config.reviewdatas,
        _busguid = config.busguid,
        _viewtype = config.viewtype,
        _workflow = config.workflow,
        _procode = config.procode,
        _isotherquery = config.isquery
    ;
    _proguid = config.proguid;
    _showtab = config.showtab; //页签展示
    _bustype = config.bustype;
    _mainguid = config.mainguid;
    var cmp = {};

    $(function (){
        common.initDatatable(indexdatatable);
        common.initDatatable(reviewdatatable);
        cmp.bulidTopHead();
        //部门项目隐藏页签
        if(_bustype == 'dept'){
            _showtab = '3';
            document.getElementById("tabpage").style.display = "none";
            $("#tophead").hide();
        };
        if (_showtab == 3){
            _curtab = "year";
            $("#tabpage").find('li').eq(0).hide();
        }
        //查看评审意见隐藏
        if(_viewtype == 'query'&&!_isotherquery){
            document.getElementById("tabpage").style.display = "none";
            document.getElementById("indexdatatable").style.display = "none";
        }
        var cols = editform.cfg.data;
        var c = {};
        for (var i=0; i<cols.length; i++) {
            if (cols[i].colcode == "FOPINION" && _reviewnum > 1) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            if (cols[i].colcode == "SOPINION" && _reviewnum <= 1) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            if(_viewtype == 'query'){
                c[cols[i].colcode.toLowerCase()] = true;
            }
        }
        editform.setdisabled(c);//设置基本信息不可编辑
        //indexdatatable.setDatas(_indexdatas);
        reviewdatatable.setDatas(_reviewdatas);
        editform.synchEditform(_editdatas[0]);
        findindex();
        parent._isQuery = true;
        if(_SYSTEMSTYLE_ == "grey"){
            $("#reviewdatatable").find(".titlename").siblings().hide();
        }
    })
    window.onload = function () {
        setTimeout(function(){
            if(_bustype == 'DEPT'){
                $("#tabpage").find('li').eq(0).hide();
                $("#tabpage").find('li').eq(1).hide();
                _showtab = '3';
            };
            if (_showtab == '3'){
                _curtab = "year";
                $("#tabpage").find('li').eq(0).hide();
                $("#tabpage").find('li').eq(1).hide();
            }
            findindex();
        },100);

    }

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
     * 保存评审信息
     * @returns {*}
     */
    cmp.save = function(){
        var reviewdatas = reviewdatatable.getRecordSet().toArray();//评审表
        for (var i = 0,leni = reviewdatas.length; i < leni; i++) {
            var a = reviewdatas[i].sreview;
            if ((!reviewdatas[i].sreview || reviewdatas[i].sreview == "") && _reviewnum > 1) {
                Ext.lt.ui.alert('请完整填写表格评审意见！');
                return ;
            }
            if ((!reviewdatas[i].freview || reviewdatas[i].freview == "") && _reviewnum <= 1) {
                Ext.lt.ui.alert('请完整填写表格评审意见！');
                return ;
            }
        }
        var editdatas = editform.getEditFormValues();
        if(editdatas.sopinion == "" && _reviewnum > 1){
            Ext.lt.ui.alert('请完整填写编辑区评审意见信息！');
            return ;
        }
        if(editdatas.fopinion == "" && _reviewnum <= 1){
            Ext.lt.ui.alert('请完整填写编辑区评审意见信息！');
            return ;
        }
        var params = {};
        params.reviewdatas = reviewdatas;
        params.editdata = editdatas;
        params.proguid = _proguid;
        params.workflow = _workflow;
        params.mainguid = _mainguid;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "savedatas", params);
        Ext.lt.ui.loadingClose();
        return rs;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
        var cols = data.cols;
        if(data.table.config.id == "reviewdatatable") {
            for(var i=0; i<cols.length; i++) {
                var col = cols[i];
                if(_viewtype == 'query'){
                    col.style = "background-color:#f2f2f2;";
                    col.oneditstart = function(table, e, l, c, d){
                        return false;
                    }
                }
                if (col["colcode"] == "sreview") { //不用选择释放此列
                    if(_reviewnum <= 1){
                        col.style = "background-color:#f2f2f2;";
                    }
                    col.oneditstart = function(table, e, l, c, d){
                        if (_viewtype == 'query'){
                            return false;
                        }
                        if(_reviewnum <= 1){
                            return false;
                        }
                    }
                }
                if (col["colcode"] == "freview") { //不用选择释放此列
                    if(_reviewnum > 1){
                        col.style = "background-color:#f2f2f2;";
                    }
                    col.oneditstart = function(table, e, l, c, d){
                        if (_viewtype == 'query'){
                            return false;
                        }
                        if(_reviewnum > 1){
                            return false;
                        }
                    }
                }
                if (col["colcode"] == "proposal") { //备注
                    col.oneditstart = function(table, e, l, c, d){
                        if (_viewtype == 'query'){
                            return false;
                        }
                        return false;
                    }
                }
            }
        } else {
            for(var i=0; i<cols.length; i++) {
                var col = cols[i];
                if(col["name"] != "check"){
                    col.style = "background-color:#f2f2f2;";
                    col.oneditstart = function(table, e, l, c, d){
                        return false;
                    }
                }
            }
        }
    });

    /**
     * 点击页签.
     */
    cmp.clickTabpage = function(obj){
        if(_bustype == 'DEPT'){
            $("#tabpage").find('li').eq(0).hide();
            $("#tabpage").find('li').eq(1).hide();
            _showtab = '3';
        };
        _tabtype = obj.code;
        if (_showtab == 3 && obj.code =="total"){
            _curtab = "year";
            $("#tabpage").find('li').eq(0).hide();
        }
        if (_showtab == 2){
            $("#tabpage").find('li').eq(1).hide();
        }
        findindex();
    }

    cmp.colse = function(){
        try{
            parent.Ext.lt.ui.closeModalWindow();
        }catch (e) {
            parent.Ext.lt.frame.window.hide();
        }
    }

    function findindex(){
        var params = {};
        params.tabtype = _tabtype;
        params.bustype = _bustype;
        params.proguid = _proguid;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "findIndex", [params], function(data) {
            indexdatatable.setDatas(data);
        })
        Ext.lt.ui.loadingClose();
        if(_bustype == 'DEPT'){
            $("#tabpage").find('li').eq(0).hide();
            $("#tabpage").find('li').eq(1).hide();
            _showtab = '3';
        };
    }
    return cmp;
}




