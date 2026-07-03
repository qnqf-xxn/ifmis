if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.performanceopen){
    Ext.lt.pmkpi.performanceopen = {};
}

Ext.lt.pmkpi.performanceopen.auditservice = function(config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service;
    var guids = config.guids,
        _workflow = config.workflow,
        //_audittype = config.audittype,
        _audittypedatas = config.audittypedatas,
        _tablecode = config.tablecode,
        _busguid = config.busguid,
        _viewtype = config.viewtype,
        _isfirst = true;
        //_data = config.data;

    window.parent.Ext.lt.pmkpi.childwindow = window;


    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initEditForm();
        if (_viewtype == "query") {
            var c = {};
            c["opinion"] = true;
            editform.setdisabled(c);//设置基本信息不可编辑
            try{
                $("div[compid='toolbutton']").hide();
            }catch (e){
                document.getElementsByClassName("winfooter")[0].style.display = "none";
            }
        }
        //editform.synchEditformByObj(_data);
    })

    /**
     * 保存
     */
    cmp.save = function () {
        if (!editform.check()) {
            return;
        }
        var params = {};
        var infodata = editform.getEditFormValues();
        params.guids = guids;
        params.workflow = _workflow;
        var actionname = "";
        if (infodata.ordinarytype == "audit") {
            actionname = "审核";
        } else if (infodata.ordinarytype == "back") {
            actionname = "退回";
        }
        infodata.opinion = $("textarea[name='opinion']").val();
        params.editinfo = infodata;
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.datas = window.parent.datatable.getSelected();
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs) {
            if (rs && rs.success) {
                Ext.lt.ui.alert(actionname + '成功！', function () {
                    try {
                        Ext.lt.ui.closeModalWindow();
                        window.parent.Ext.lt.pmkpi.query();
                        window.parent.Ext.lt.pmkpi.querytree();
                    } catch (e) {
                        parent.Ext.lt.frame.window.hide();
                    }
                });
            } else {
                Ext.lt.ui.alert(rs.code,function(){
                });
            }
            Ext.lt.ui.loadingClose();
        }, function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(actionname + '失败！',function(){
            });
        });
    }
    /**
     * 关闭页面
     */
    cmp.close = function () {
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    }

    Ext.lt.message.hook("editform", "drawed", function (resp) {
        var table_eva = {
            oldopinion: {
                change: function (param) {
                    var opinion = param._value.text;
                    if (opinion && "" != opinion) {
                        $('textarea[name="opinion"]').val(opinion);
                    } else {
                        _isfirst = false;
                    }
                }
            },
            ordinarytype:{
                asyncloaddata:function(param){
                    param.data = _audittypedatas;
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);

    });

    return cmp;
}