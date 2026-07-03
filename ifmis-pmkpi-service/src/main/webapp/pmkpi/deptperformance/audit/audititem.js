if(!Ext.lt.pmkpi){
	Ext.lt.pmkpi = {};
}
Ext.lt.pmkpi.auditservice = function(config, serviceid){
	var _cmp={};
	var _audittype = config.audittype;
	Ext.lt.pmkpi.audittype = _audittype;

	$(function () {
		if ($("input[name^='conaudittype']").prev()){
			$("input[name^='conaudittype']").prev().width(80);
		}

		if ($("input[name^='audittype']").prev()){
			$("input[name^='audittype']").prev().width(80);
		}

		if ($("input[name^='pinggutype']").prev()){
			$("input[name^='pinggutype']").prev().width(80);
		}
	})

	return _cmp;
}

