if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.baseinfoedit)
    Ext.lt.pmkpi.baseinfoedit = {};
var serviceid;
var deptcmp;
var _isQuery;
Ext.lt.pmkpi.baseinfoedit = function (config, service) {
    deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var userGuid = "", userCode = "", userName = "";
    serviceid = service;
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var _viewtype = config.viewtype,
        _tablecode = config.tablecode,
        _guid = config.guid,
        _tabData = config.tabData,
        _isSx = config.isSx,
        _componentid,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;


    $(function () {
        if (_viewtype != "add") {
            //单独为专家库增加的个性化
            if(_tablecode=="V_PERF_EXPERTINIFO") {
                config.datas.guid = config.datas.guid + "#" + config.datas.code;
            }
            // setTimeout(function(){
                editform.synchEditformByObj(config.datas);
            //     Ext.lt.ui.loadingClose();
            //
            // },300);
        }
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
            $(".winfooter").hide();
            deptcmp.editSetdisabled(editform);
        }
        _isQuery = true;
    })

    /**
     * 保存
     */
    cmp.infosave = function () {
        if(_isSx == "isSx") {  //山西模式，调用共用保存方法
            var params= {};
            params.isadd = Ext.lt.pmkpi.isadd;
            var rs = deptcmp.savedatas(obj, params);
            if (rs) {
                try{
                    window.parent.Ext.lt.pmkpi.query();
                }catch (e){}
            }
        }else {
            if (!editform.check()) return;//先校验
            var params = {};
            params.tablecode = _tablecode;
            params.viewtype = _viewtype;
            if (_guid) {
                params.guid = _guid;
            }
            params.data = editform.getEditFormValues();
            //单独为专家库增加的个性化
            if (_tablecode == "V_PERF_EXPERTINIFO") {
                if (userGuid && userCode) {
                    params.data.guid = userGuid;
                    params.data.code = userCode;
                    params.data.name = userName;
                } else {
                    var userCodeAndGuid = params.data.guid.split("#");
                    params.data.guid = userCodeAndGuid[0];
                    params.data.code = userCodeAndGuid[1];
                }
            }

            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(service, "saveDatas", params, function (rs) {
                if (rs && rs.success) {
                    Ext.lt.ui.alert('保存成功！', function () {
                        if (_isSx == "isSx") {
                            Ext.lt.ui.loadingClose();
                            window.parent.Ext.lt.pmkpi.query();
                        } else {
                            Ext.lt.ui.closeModalWindow();
                            window.parent.Ext.lt.pmkpi.query();
                        }
                    });
                } else {
                    Ext.lt.ui.alert('保存失败！', function () {
                    });
                }
                Ext.lt.pmkpi.query();
                Ext.lt.ui.loadingClose();
            }, function () {
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('保存失败！', function () {
                });
            });
        }
    }


    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    cmp.addfile = function () {
        var params = {};
        var url = "/pmkpi/file/index.page";
        params.mainguid = _guid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "文件上传");
    }

    /**
     * 页签方法
     */
    cmp.clickTabpage = function(obj){
        deptcmp.tabpageOnclick(obj, _tabData, toolbutton);
        _componentid = obj.componentid;
    }

    //专家库人员选择会触发这个
    Ext.lt.message.hook("editform", "drawed", function (resp) {
        if(_tablecode=="V_PERF_EXPERTINIFO"){
            var table_eva = {
                guid: {
                    change: function (param) {
                        var userCodeAndGuid = param._value.value.split("#");
                        userGuid = userCodeAndGuid[0];
                        userCode = userCodeAndGuid[1];
                        userName = param._value.text;
                    }
                }
            }
            resp.editformpanel.attachEvent(table_eva);
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
        _table_param[componentid + "_totaltag"] = obj.uiconfig.totaltag;
    });




    /**
     * 点击嵌套页面类型处理消息
     */
    Ext.lt.message.hook("perfcommon", "iframeinit",function(obj){
        var params = obj.params;
        params.mainguid = _guid;
        params.viewtype = _viewtype;
    });

    return cmp;
}