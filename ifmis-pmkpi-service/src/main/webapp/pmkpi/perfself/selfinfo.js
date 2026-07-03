if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.selfinfo){
    Ext.lt.pmkpi.selfinfo = {};
}

Ext.lt.pmkpi.selfinfo = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _mainguid = config.mainguid,
        _projguid = config.projguid,
        _procode = config.procode,
        _saveAgency = config.saveAgency,
        _bustype = config.bustype,
        _viewtype = config.viewtype,
        _savetable,//保存的表
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _busguid = config.busguid;//审核定义guid
    var cmp = {};
    
    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.compconfigid = "editform";
        params.url = editform.cfg.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
        	editform.synchEditformByObj(rs.data);
            setMidSaveHidButtons(rs);
            if (isquery) {
                parent._isQuery = true;
            }
        },function(){
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }
    /**
     * 保存.
     * @returns {*}
     */
    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        var params = {};
        params.datas = editform.getEditFormValues();
        params.tablecode = _savetable; //保存的表
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.procode = _procode; //项目code
        params.busguid = _busguid;
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.url = editform.cfg.pageurl;
        params.componentid = editform.cfg.server;
        params.compconfigid = "editform";
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.data = editform.getEditFormValues();
        params.url = editform.cfg.pageurl;
        params.componentid = editform.cfg.server;
        params.compconfigid = "editform";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.url = editform.cfg.pageurl;
        params.componentid = editform.cfg.server;
        params.compconfigid = "editform";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initEditForm();
        if (_viewtype == "query") {
            var cols = editform.cfg.data;
            var c = {};
            for (var i=0; i<cols.length; i++) {
                c[cols[i].colcode.toLowerCase()] = true;
            }
            editform.setdisabled(c);//设置基本信息不可编辑
        }
        _savetable = editform.cfg.table;
        cmp.query(true);
    })

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            score : {
                change: function(param){
                    var data = editform.getEditFormValues();
                    var score = data.score;
                    if(data.score) {
                        spstr = score.split(".");
                        var aaa = spstr[spstr.length-1];//最后一位如果是小数点 则不校验
                        if(aaa) {
                            if (!checkReferencepole(data.score)) {
                                var nullval = {};
                                nullval.score = 0;
                                editform.getCol("score").bind(nullval);
                            }
                        }
                    }
                }
            },
            selfscore : {
                change: function(param){
                    var data = editform.getEditFormValues();
                    var selfscore = data.selfscore;
                    if(data.selfscore) {
                        spstr = selfscore.split(".");
                        var aaa = spstr[spstr.length-1];//最后一位如果是小数点 则不校验
                        if(aaa) {
                            if (!checkReferencepole(data.selfscore)) {
                                var nullval = {};
                                nullval.selfscore = 0;
                                editform.getCol("selfscore").bind(nullval);
                            }
                        }
                        //如果页面显示等级（selfgrad）则根据规则触发显示 优良差等
                        var changgrad = {};
                        var tempgrad = "";
                        if(data.selfscore>90){
                            tempgrad = "优";
                        }else if (data.selfscore>80){
                            tempgrad = "良";
                        }else if (data.selfscore>60){
                            tempgrad = "中"
                        } else {
                            tempgrad = "差";
                        }
                        changgrad.selfgrade = tempgrad;
                        editform.getCol("selfgrade").bind(changgrad);
                    }
                },
                blur:function (param){
                    var data = editform.getEditFormValues();
                    var selfscore = data.selfscore;
                    if(selfscore && editform.getCol("selfgrade")) {
                        //如果页面显示等级（selfgrad）则根据规则触发显示 优良差等
                        var changgrad = {};
                        var tempgrad = "";
                        if(selfscore>=90){
                            tempgrad = "优";
                        }else if (selfscore>=80){
                            tempgrad = "良";
                        }else if (selfscore>=60){
                            tempgrad = "中"
                        } else {
                            tempgrad = "差";
                        }
                        changgrad.selfgrade = tempgrad;
                        editform.getCol("selfgrade").bind(changgrad);
                    }
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    return cmp;
}

/**
 * 只能输入数字校验
 * @param referencepole
 * @returns {boolean}
 */
function checkReferencepole (str){
    var re = /^\d{1,3}(\.\d{1,2})?$/;
    if(!re.test(str)){
        Ext.lt.ui.alert("请输入数字且保留2位小数！");
        return false;
    }else{
        return true;
    }
}