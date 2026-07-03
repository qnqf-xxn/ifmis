Ext.lt.pmkpi.questanswerservice = function (config, serviceid){
	var _cmp = {};
	var _pwindow = parent.Ext.md.window;
	var _parent = window.parent.Ext.md.perf;
	    _parent.childwindow = window;
	var _question =_parent.question;
	var _asmap = _parent.asmap;
	var _datas = _parent.datas;
	var _pageno = _parent.pageno;
	var _pagesize = _datas.length;
	var $radio;
	
	/**
	 * 加载完成后执行.
	 */
	Ext.md.msg.hook("page_onload", function(region) {
		$radio = editform.getColObj("answer");
		editform.setAllValue(_question);
	});
	
	/**
	 * 上一项
	 */
	_cmp.pre = function(){
		var _preno = _pageno - 1;
		if(_preno <= 0) {
			alert("当前页已经是第一页！");
			return;
		}
		_setValue();
		_pageno = _preno;
		_question = _datas[_pageno];
		_set_r_val("pre");
	}

	/**
	 * 下一项
	 */
	_cmp.next = function(){
		var _nextno = _pageno + 1;
		if(_nextno >= _pagesize) {
			alert("当前页已经是最后一页！");
			return;
		}
		_setValue();
		_pageno = _nextno;
		
		_set_r_val();
	}

	/**
	 * 完成
	 */
	_cmp.save = function(){
		_setValue();
		Ext.md.window.closeCurrentOpenWindow();
	}
	
	function _setValue(){
		Ext.md.window.mask();
		setTimeout(function(){ Ext.md.window.unmask(); }, 300);
		_datas[_pageno]["answer"] = editform.getValue("answer");
		editform.clearAll();
	}
	function _set_r_val(flag){
		_question = _datas[_pageno];
		if(_question["sumrow"]){
			if(flag=="pre"){
				_cmp.pre();
			}else{
				_cmp.next();
			}
		}else{
			$radio.setData(_question.as);
			editform.setAllValue(_question);
		}
	}
	/**
	 *
	 */
	Ext.md.msg.hook("ui_editform_a_beforedrawcol",function(obj){
		var _columncode = obj.colconfig.columncode;
		if(_columncode == "answer"){
			obj.colconfig.getdata = function(col,func){
				func(_question.as);
			}
			
		}
	});
	return _cmp;
}




