if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.aisendaudit = function(config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _api_key = config.api_key,
        _api_code = config.api_code,
        _datacols = config.datacols,
        _queryset = config.queryset,
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight
    ;

    window.parent.Ext.lt.pmkpi.childwindow = window;

    /**
     * 确定
     */
    cmp.audit = function (btn) {
        var datas = parent.datatable.getSelected();
        var params = {};
        params = editform.getEditFormValues();
        params.datas = datas;
        var tst = Object.keys(config);
        for(var j = 0,len=tst.length; j < len; j++) {
            var vualue = config[tst[j]];
            if (isString(vualue) || isNumber((vualue))) {
                params[tst[j]] = vualue;
            }
        }
        params.actionname = btn.name;
        params.actioncode = btn.code;
        parent.Ext.lt.pmkpi.auditdata = null;
        window.parent.Ext.lt.pmkpi.sendWFAction(params);
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

    $(function () {
        var _viewdiv = document.createElement("div");
        _setFrame(_viewdiv);
        _viewdiv.id = "aisendauditdiv";
        var _viewiframe = document.createElement("iframe");
        _setFrame(_viewiframe);
        _viewiframe.id = "aisendaudit_iframe";
        _viewiframe.src = cmp.AIaudit();
        _viewdiv.appendChild(_viewiframe);
        var divobj =  document.getElementById("editform");
        $('.bd_main')[0].insertBefore(_viewdiv,divobj);
    });

    function _setFrame(obj){
        obj.setAttribute('frameBorder', 0);
        obj.style.cssText = 'border: 0 none;';
        obj.width = _scrWidth;
        obj.height = _scrHeight-185;
    }

    // Ai辅助审核
    cmp.AIaudit = function () {
        var message="绩效审核";
        var param = {api_key:_api_key, api_code: _api_code,message:message, queryset:_queryset, datacols:_datacols}; // 业务查询接口参数-查询AI解析需要的数据
        for (var i=0;i<_datacols.length; i++) {
            param[_datacols[i]] = config[_datacols[i]];
        }
        var buttons = [];
        var params = {};
        params.message = message;
        params.params = JSON.stringify(param);
        params.buttons = JSON.stringify(buttons);
        var url = "/aipage/assistance?pagetitle=智能辅助审核";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        return url;
    }

    return cmp;
}