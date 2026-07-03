if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.treeindexquantity) {
    Ext.lt.pmkpi.treeindexquantity = {};
}
var serviceid;
var _viewtype;
Ext.lt.pmkpi.treeindexquantity = function (config, service) {
    var commcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var  _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid = config.busguid,//审核定义guid，
        _procode = config.procode,
        _payid = config.payid,
        _signs = config.signs,
        _ismergeindex = config.ismergeindex,
        _curprovince = config.curprovince,
        _curyear = config.curyear,
        _pagetype = config.pagetype,
        _viewtype = config.viewtype;
    _scrWidth = document.body.clientWidth,
    _scrHeight = document.body.clientHeight;
    serviceid = service;
    var cmp = {};

    /**
     * 表格获取.
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });
    /**
     * 查询信息.
     */
    cmp.query = function (isquery) {
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.procode = _procode; //项目code
        params.payid = _payid;
        params.viewtype = _viewtype;
        params.curprovince = _curprovince;
        params.curyear = _curyear;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", params, function (rs) {
            datatable.setDatas(rs.datas);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.pmkpi.alert('查询失败！', function () {
            });
        });
    }

    cmp.indexCheckAll = function (){
        var cols = datatable.getCols(); //获取列表所有列
        var datas = datatable.getRecordSet().toArray();
        for (var i = 0,leni = datas.length; i < leni; i++) {
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1') {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.pmkpi.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }

    cmp.save = function () {
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        if (!cmp.indexCheckAll()) return false;//先校验
        var datas = datatable.getRecordSet().toArray();
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.procode = _procode; //项目code
        params.payid = _payid;
        Ext.lt.ui.loadingShow();
        if(!datas || datas.length == 0) {
            var rs = {};
            rs.success = true;
            Ext.lt.ui.loadingClose();
            return rs;
        }
        var rs = Ext.lt.RCP.asyncall(serviceid, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
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
                            Ext.lt.pmkpi.alert("请先选择计算符号！",{timeout:1},function(){});
                            d.indexval = '';
                            return false;
                        }
                    }
                    if(d.rowtype!="add"){
                        d.rowtype ="mod";
                    }
                    if(d.computesign == "9"){
                        d["kpivalsource"] = d["indexval"];
                    }
                }
            }
            if (_viewtype == 'query' && !config[col.colcode]  && col["name"] != "check" && col["colcode"] != "file") {
                if (_pagetype == "audit" && (col["colcode"] == "opinion_remark" || col["colcode"] == "audit_score")) {
                    continue;
                }
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
                            if (d.levelno != "3" || d.isedit != "1") {
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
        if(rowdata.isleaf == 0){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        commcmp.initDatatable();
        cmp.query(true);
    })

    return cmp;
}

/**
 * 只能输入数字校验
 * @param referencepole
 * @returns {boolean}
 */
function checkReferencepoles (str){
    var re = /^(-?\d+)\.?(\d*)$/;//支持录入负数
    if(!re.test(str)){
        Ext.lt.pmkpi.alert("定量指标的指标值为数值！");
        return false;
    }else{
        return true;
    }
}

function getPointNum(num) {
    var str = String(num);
    var index = str.split(".");
    var str1 = null;
    if (index.length == 2) {
        str1 = index[1].substring(0, 2);
        str1 = Number(index[0] + "." + str1);
    } else {
        str1 = Number(index[0]);
    }
    return str1;
}

function doMapper(rs, col) {
    var mapping = [];
    var columns = [];
    for (var i = 0; i < rs.size(); i++) {
        var arr = [];
        arr.push(rs[i].guid);
        arr.push(rs[i].code);
        arr.push(rs[i].name);
        columns.push(arr);
        mapping[rs[i].code] = arr;
    }
    col.mapping = mapping;
    col.mapper = {};
    col.mapper.columns = ['guid', 'code', 'name', 'supcode', 'pinyin'];
    col.mapper.datas = columns;
    col.mapper.regs = ['#guid', '#code', '#name', '#supcode', '#pinyin'];
    col.mapper.default_column = 'code';
    col.format = '#name';
}

