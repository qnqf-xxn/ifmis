if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}

Ext.lt.pmkpi.financialevaluation.resulteditservice = function(config, service){
    var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var cmp = {};
    var serviceid = service,
        _mainguid = config.mainguid,//主单id
        _menuid = config.menuid,//菜单id
        _saveAgency = config.saveAgency,
        _workflow = config.workflow;
    Ext.lt.pmkpi.isadd = false;
    /**
     * 基础信息保存
     */
    cmp.save = function (obj){
        if (!editform.check()) return false;
        var params = {};
        var infodata = editform.getEditFormValues();
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.menuid = _menuid;
        params.tablecode = editform.cfg.tablecode;
        params.iswf =  editform.cfg.iswf;
        params.procode = config.procode;
        params.querycode = config.querycode;
        params.bustype = config.bustype;
        params.proguid = config.proguid;
        params.infodata = infodata;
        var rs = Ext.lt.RCP.asyncall(serviceid , "infosave", params);
        return rs;
    }

    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        perfcommon.initEditForm();
        var tablecode = editform.cfg.tablecode;
        var params = {};
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.menuid = _menuid;
        params.tablecode = tablecode;
        params.iswf =  editform.cfg.iswf;
        params.procode = config.procode;
        params.querycode = config.querycode;
        params.bustype = config.bustype;
        params.proguid = config.proguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "editquery", params, function(rs){
            var data = rs.editdata;
            editform.synchEditformByObj(data);
            Ext.lt.ui.loadingClose();
            parent._isQuery = true;
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(("查询失败！"),{}, function(ret) {
            });
        });
    });


    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            //评价分值
            score : {
                change: function(param){
                    var data = editform.getEditFormValues();
                    var s = data.score;
                    if(data.score) {
                        spstr = s.split(".");
                        var aaa = spstr[spstr.length-1];//最后一位如果是小数点 则不校验
                        if(aaa) {
                            if (!checkScore(data.score)) {
                                var nullval = {};
                                nullval.score = 0;
                                nullval.grade = "差";
                                editform.getCol("score").bind(nullval);
                                editform.getCol("grade").bind(nullval);
                            }
                        }
                    }
                    var grade;
                    if(s>90 && s<100){
                        grade = "优";
                    }else if(s>80 && s<90){
                        grade = "良";
                    }else if(s>60 && s<80){
                        grade = "中";
                    }else{
                        grade = "差";
                    }
                    var values = {};
                    values.grade = grade;
                    editform.getCol("grade").bind(values);
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });


    /**
     * 只能输入数字校验
     * @param referencepole
     * @returns {boolean}
     */
    function checkScore (str){
        var re = /^(((\d|[1-9]\d)(\.\d{1,2})?)|100|100.0|100.00)$/;
        if(!re.test(str)){
            Ext.lt.ui.alert("评价分值只能输入0-100数字(两位小数)！");
            return false;
        }else{
            return true;
        }
    }
    return cmp;
}