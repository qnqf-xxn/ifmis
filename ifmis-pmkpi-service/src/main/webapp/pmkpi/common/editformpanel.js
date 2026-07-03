if (!Ext.lt.budget) Ext.lt.budget = {};
if (!Ext.lt.budget.jxgl) Ext.lt.budget.jxgl = {};


Ext.lt.budget.jxgl.editformpanel = function(config, service) {
	var editform = new Ext.lt.bus.ui.editformpanel(config);
	
	var tagel = null, $tagel = null, paneldefault = {};
	
	editform.resize = function(w, h){
		var height = h || tagel.offsetHeight;
		var width = w || tagel.offsetWidth;
		tagel.style.width = width + "px";
	}
	
	editform.synchEditform=function(resp){
		for(var o in resp){
			var col = editform.getCol(o);
			if(!col) continue;
			
			var _target = $tagel.find("input[elementcode="+o+"]");
			if(_target.length!=0) setValue[col._cfg.type](_target.get(0),resp[o],o);
			
			var _targetText = $tagel.find("textarea[elementcode="+o+"]");
			if(_targetText.length!=0) setValue[col._cfg.type](_targetText.get(0),resp[o],o);
		} 
    }
	
	/**
	 * 单选按钮设置值
	 */
	function setVByName(name,value){
		var tt = document.getElementsByName(name);
        for (var iIndex = 0; iIndex < tt.length ; iIndex++ )
        {
        	if(value==tt[iIndex].value){
        		tt[iIndex].checked = true;
        	}else{
        		tt[iIndex].checked = false;
        	}
        }
	}
	
	
	/**
	 * 获取单选按钮的值
	 */	
    function getVByName(name){
        var tt = document.getElementsByName(name);
        for (var iIndex = 0; iIndex < tt.length ; iIndex++ )
        {
            if(tt[iIndex].checked)
            {
            	 return tt[iIndex].value;
            }
        }
    };
	
	editform.getEditFormValues = function(){
		var eles = this.form.elements;
		
		var values = {};
		for(var i=0,n=eles.length; i<n; i++){
			var col = editform.getCol(eles[i]);
			if(!col) continue;
			
			var _target = $tagel.find("input[elementcode="+eles[i]+"]");
			if(_target.length!=0)values[eles[i]] = getValue[col._cfg.type](_target.get(0),eles[i]);
			
			var _targetText = $tagel.find("textarea[elementcode="+eles[i]+"]");
			if(_targetText.length!=0)values[eles[i]] = getValue[col._cfg.type](_targetText.get(0));
			
		}
		
		return values;
	}
	
	editform.getEditFormValuesForAll = function(){
		var eles = this.form.elements;
		
		var values = {};
		for(var i=0,n=eles.length; i<n; i++){
			var col = editform.getCol(eles[i]);
			if(!col) continue;
			
			var _target = $tagel.find("input[elementcode="+eles[i]+"]");
			if(_target.length!=0)values[eles[i]] = getValueForAll[col._cfg.type](_target.get(0),eles[i]);
			
			var _targetText = $tagel.find("textarea[elementcode="+eles[i]+"]");
			if(_targetText.length!=0)values[eles[i]] = getValueForAll[col._cfg.type](_targetText.get(0));
		}
		
		return values;
	}

	editform.draw = function(el){
		tagel = el; 
		$tagel = $(el);
		initLayout(el);
	}
	  
	
	editform.setdisabled = function(obj){
		for(var o in obj) {
			$tagel.find("input[elementcode="+o+"]").attr("disabled", obj[o]);
			$tagel.find("textarea[elementcode="+o+"]").attr("disabled", obj[o]);			
		}
	}
	
	editform.check = function(){
//		for(var o in obj) {
//			$tagel.find("input[elementcode="+o+"]").attr("disabled", obj[o]);
//			$tagel.find("textarea[elementcode="+o+"]").attr("disabled", obj[o]);			
//		}
		return true;
	}
	
	editform.setVisiable = function(obj){
		for(var o in obj){
			$tagel.find("input[elementcode="+o+"]").css("display", obj[o]);
			$tagel.find("span[elementcode="+o+"]").css("display", obj[o]);
			$tagel.find("textarea[elementcode="+o+"]").attr("disabled", obj[o]);
		}
	}
	
	editform.getRegion=function(){return tagel;}
	
	editform.getDefaultValues = function(){return paneldefault;}
	
	editform.clear = function(){		
		var eles = this.form.elements;		
		for(var i=0,n=eles.length; i<n; i++){
			var col = editform.getCol(eles[i]);
			if(!col) continue;
			
			var _target = $tagel.find("input[elementcode="+eles[i]+"]");
			if(_target.length!=0) setValue[col._cfg.type](_target.get(0),"",eles[i]);

			
			var _targetText = $tagel.find("textarea[elementcode="+eles[i]+"]");
			if(_targetText.length!=0) setValue[col._cfg.type](_targetText.get(0),"");
		}
	}
	
	editform.changeDisplay = function(status){
		var cs = $tagel.find(".body").children();
		
		if(status){
			cs[2].style.display="";
		}
	}
	
	editform.reset = function() {
		editform.clear();
		editform.synchEditform(paneldefault);
    }
	
	var setValue = {
			"_treeselect" : function(target, _value,o){
				target.value = _value.text || "";
				target._value = _value.value || "";
			},
			"_input" : function(target, _value,o){
				target.value = _value || "";
			},
			"_boolean" : function(target, _value,o){
				setVByName(o,_value);
			},
			"_textarea": function(target, _value,o){
				target.value = _value || "";
			},
			"_amtinput" : function(target, _value,o){
				if(_value==null){
					target.value =  null;
					target.o_value = null; 
					target.t_value = null;
				}else{
					if(_value==""){
						_value = 0 ;
					}
					target.value = (_value+"").toNumber(2,false,1); //金额单位
					target.o_value = (_value+"").toNumber(2,false,1); //金额单位
					target.t_value = (_value+"").toNumber(2,false,1); //金额单位
				}
			}
	}
	
	var getValue = {
			"_treeselect" : function(target){
				return target._value || "";
			},
			"_input" : function(target){
				return target.value || "";
			},
			"_boolean" : function(target,o){
				return getVByName(o)||"";
			},
			"_textarea": function(target){
				return target.value || "";
			},
			"_amtinput" : function(target){
				return target.value || "";
			}
	}
	
	var getValueForAll = {
			"_treeselect" : function(target){
				return {text:(target.value || ""),value:(target._value || "")};
			},
			"_input" : function(target){
				return {value:target.value || ""};
			},
			"_boolean" : function(target,o){
				return {value:getVByName(target.name)|| ""};
			},
			"_textarea": function(target, _value,o){
				return {value:target.value || ""};
			},
			"_amtinput" : function(target){
				return {value:target.value || ""};
			}
	}
	
	var initLayout = function(el){
		var _html = [];		
		_html = createhtml($tagel,config.tab,config.colconfig) ;
		
		el.innerHTML = _html.join("").replace(/\t/g,"");

		var o1 = {}, o2 = {}, o3 = {} ;
		$tagel.find("input").each(function(){
			var colCode = $(this).attr("elementcode");
			if(colCode){
				var col = editform.getCol(colCode);
				if(col){
					if(!col._cfg.isedit) o1[col.name] = true;
					
					if(col._cfg.defaultvalue != null){
						o2[col.name] = col._cfg.defaultvalue;
					}
					if(!col._cfg.isvisiable) 
						o3[col.name] = "none"; 
				}
				
			}			
		});
		
		$tagel.find("textarea").each(function(){
			var colCode = $(this).attr("elementcode");
			if(colCode){
				var col = editform.getCol(colCode);
				if(col){
					if(!col._cfg.isedit) o1[col.name] = true;
					
					if(col._cfg.defaultvalue != null){
						o2[col.name] = col._cfg.defaultvalue;
					}
					if(!col._cfg.isvisiable) 
						o3[col.name] = "none"; 
				}
				
			}			
		});
		
		editform.setdisabled(o1);
		editform.setVisiable(o3);
		editform.synchEditform(o2);
		
		paneldefault = Ext.lt.cloneobj(o2);
	}
	
	return editform;
}