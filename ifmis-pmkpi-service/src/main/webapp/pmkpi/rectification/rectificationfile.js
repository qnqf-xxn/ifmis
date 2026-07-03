if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.rectification){
    Ext.lt.pmkpi.rectification = {};
}

Ext.lt.pmkpi.rectification.rectificationfile = function(config, service) {
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _viewtype = config.viewtype,
        _bustype = config.bustype,
        _mainguid = config.mainguid,
        _workflow = config.workflow,
        _rectype = config.rectype,
        _rectifyType = config.rectifyType,
        _filebustype = config.filebustype,
        _treeid = config.treeid,
        _isHUBEI = config.isHUBEI,
        _tablecode,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _defquery,
        _checkguid = config.checkguid,
        height = $(window).height()*0.8,
        width = $(window).width()*0.8
    ;
    var _isNINGXIA = config.isNINGXIA;
    var _editdata = {};

    /**
     * 保存
     */
    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        var editinfo = editform.getEditFormValues();//获取页面上编辑框的值
        if (_isHUBEI) {//湖北保存添加特殊校验
            if ((editinfo.adjustadvice == "1" || editinfo.adjustadvice == "2") && (!editinfo.feedbackamt)) {
                Ext.lt.ui.alert(editform.getCol('feedbackamt')._cfg.label + '必填！',function(){});
                return false;
            }
            if ((editinfo.adjustadvice == "3" || editinfo.adjustadvice == "4") && (!editinfo.feedbackremark || editinfo.feedbackremark == "")) {
                Ext.lt.ui.alert(editform.getCol('feedbackremark')._cfg.label + '必填！',function(){});
                return false;
            }
        }
        var params = {};
        Ext.lt.ui.loadingShow();
        params.mainguid = _mainguid;
        params.workflow = _workflow;
        params.viewtype = _viewtype;
        params.bustype = _bustype;
        params.type = _rectifyType;
        params.rectype = _rectype; //业务阶段  1：绩效监控  2：绩效自评  3:部门评价  4：财政评价
        params.rectifycontent = $.extend(_editdata, editinfo);
        params.editformtype = _filebustype;//附件也编辑框内容类型
        params.rectifysData = window.parent.parent.datatable.getSelected(); //获取选择列表数据
        params.treeid = _treeid;
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        Ext.lt.ui.loadingClose();
        return rs;
    }

    /**
     * 保存并送审
     */
    Ext.lt.pmkpi.saveandaudit = function(obj){
        var rs = cmp.save();
        var datas = rs.datas;
        if (datas){
            setTimeout(function(){
                try{
                    parent.parent.Ext.lt.pmkpi.sendandudit(obj,datas);
                }catch(e){
                    parent.parent.parent.Ext.lt.pmkpi.sendandudit(obj,datas);
                }
            },500);
        }else{
            if (rs && rs.msg) {
                Ext.lt.ui.alert(rs.msg,function(){
                });
            } else {
                Ext.lt.ui.alert('保存失败！',function(){
                });
            }

        }
        Ext.lt.ui.loadingClose();
        return rs;
    }

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        var params = {};
        params.bustype = _bustype;
        params.tablecode = _tablecode;
        params.filebustype = _filebustype;
        params.viewtype = _viewtype;
        params.mainguid = _mainguid;
        params.querySql = _defquery;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.RCP.call(service , "queryFiletype", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"||col["colcode"] == "filename"){
                col.onclick = function(td, el, l, c, d) {
                    if (d.levelno == 1) {
                        return;
                    }
                    var params = {};
                    params.filetype = d.guid;
                    params.viewtype = _viewtype;
                    params.mainguid = _mainguid;
                    params.queryYear = _queryYear;
                    params.queryProvince = _queryProvince;
                    if (isGreyStyle()) {
                        parent.window.Ext.lt.pmkpi.newfilePanelInit(params,Ext.lt.pmkpi.setFileName);
                    }else{
                        var url = "/pmkpi/file/index.page";
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,width,height,"附件上传");
                    }
                };
            }
        }
    });

    //页面加载完成后执行
    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        if (typeof(datatable) != "undefined" && datatable != null){
            commoncmp.initDatatable();
        }
        if(_SYSTEMSTYLE_ == "grey"){//附件列表 新ui去掉列表组件按钮
            $("#datatable").find(".titlename").siblings().hide();
        }
        var params = {};
        var cols = editform.cfg.data;
        var c = {};
        var hidecols = [];
        for (var i=0; i<cols.length; i++) {
            var colcode = cols[i].colcode.toLowerCase();
            c[colcode] = true;
            if (_isNINGXIA) {
                if (colcode == "rectifydesc" && cols[i].config) {
                    var cfg = eval("(" + cols[i].config + ")");
                    params[_rectype] = cfg[_rectype];
                }
                if (cols[i].config) {
                    var cfg = eval("(" + cols[i].config + ")");
                    if (cfg && cfg.showcols && !cfg.showcols.includes(_rectype)) {
                        hidecols.push(colcode);
                    }
                }
            }
        }
        //根据类型展示
        if (hidecols.length > 0) {
            editform.hide(hidecols);
        }
        if (_viewtype == "query") {
            editform.setdisabled(c);//设置不可编辑
        }
        params.mainguid = _mainguid;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        params.rectype = _rectype;
        params.checkguid = _checkguid;
        params.viewtype = _viewtype;
        params.bustype = _bustype;
        _editdata = Ext.lt.RCP.asyncall(service, "queryEdit", params);
        if (_editdata &&  Object.keys(_editdata).length !== 0) {
            editform.synchEditformByObj(_editdata);
        }
        if (typeof(datatable) != "undefined" && datatable != null) {
            Ext.lt.pmkpi.query();
        }
        parent._isQuery = true;
    });

    Ext.lt.message.hook("layout", "endlayout2", function(){
        if (typeof(datatable) != "undefined" && datatable != null) {
            datatable.resize(undefined, height);
        }
    });

    /**
     * 刷新附件列表
     */
    Ext.lt.pmkpi.setFileName = function (filenames, billguid, filetype) {
        var parent_sel_rows = datatable.getRecordset().query({guid:filetype});
        var parent_sel_obj = parent_sel_rows[0];
        //文件无修改，不处理
        if ((filenames != "" && parent_sel_obj["filename"] != filenames) || (parent_sel_obj["filename"] && filenames == "")) {
            var _sortid = parent_sel_obj._sortid;
            parent_sel_obj["filename"] = filenames;
            datatable.reflash(_sortid);
        }
    }

    return cmp;
}