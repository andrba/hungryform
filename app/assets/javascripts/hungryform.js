// Module to handle form interactions such as
// prev, next links and dependency resolution
(function($) {

  function HungryForm(form) {
    this.form = form;
    this.$form = $(form);

    this.init();
  }

  HungryForm.prototype = {
    init: function() {
      this.bindEvents();
    },

    bindEvents: function() {
      var form_action = this.$form.find("input[name='form_action']"),
          that = this;

      this.$form.find(':input').on('change select', function() {
        that.updateVisibility();
      });

      this.$form.find('input, select').keypress(function(event) { 
        return event.keyCode !== 13; 
      });

      $("a[data-rel='" + this.$form.data('rel') + "'][data-form-action]").on('click', function(event) {
        if ($(this).data('form-method') === 'get') {
          return true;
        }

        event.preventDefault();

        var action = $(this).data('form-action');
        form_action.val(action);
        that.$form.attr('action', $(this).attr('href'));
        
        that.$form.submit();
      });
    },

    updateVisibility: function() {
      var that = this;
      this.$form.find('div[data-dependency], fieldset[data-dependency]').each(function() {
        var obj = $(this);
        var dependency = obj.data('dependency');
        
        if (that.resolveDependency(dependency)) {
          that._setObjectVisibility(obj, true);
        } else {
          that._setObjectVisibility(obj, false);
        }
      });
    },

    resolveDependency: function(dependency) {
      var isDependent = false;
      var that = this;

      $.each(dependency, function(operator, args) {
        if (operator === 'eq') {
          isDependent = that._isEqual(args);
          return false;
        } else if (operator === 'lt') {
          isDependent = that._isLessThan(args);
          return false;
        } else if (operator === 'gt') {
          isDependent = that._isGreaterThan(args);
          return false;
        } else if (operator === 'not') {
          isDependent = !that.resolveDependency(args);
          return false;
        } else if (operator === 'is') {
          isDependent = that._isSet(args);
          return false;
        } else if (operator === 'and') {
          isDependent = true;
          $.each(args, function(index, argument) {
              isDependent = that.resolveDependency(argument) && isDependent;
              if (isDependent === false) {
                  //No need to check the rest of the dependencies
                  return false;
              }
          });
          return false;
        } else if (operator === 'or') {
          $.each(args, function(index, argument) {
              isDependent = that.resolveDependency(argument) || isDependent;
              if (isDependent === true) {
                  //No need to check the rest of the dependencies
                  return false;
              }
          });
          return false;
        }
      });
      
      return isDependent;
    },
    _isEqual: function(args) {
      return args.length > 1 && this._getArgument(args[0]).toString() === this._getArgument(args[1]).toString();
    },
    _isLessThan: function(args) {
      return args.length > 1 && parseFloat(this._getArgument(args[0])) < parseFloat(this._getArgument(args[1]));
    },
    _isGreaterThan: function(args) {
      return args.length > 1 && parseFloat(this._getArgument(args[0])) > parseFloat(this._getArgument(args[1]));
    },
    _isSet: function(args) {
      return typeof(args[0]) !== 'undefined' && this._getArgument(args[0]).length > 0;
    },
    _getArgument: function(argument) {
      var input = this.$form.find("input[name='" + argument + "'], textarea[name='" + argument + "'], select[name='" + argument + "']");
      
      if (input.length > 0) {
        if (input.filter(':radio').length > 0) {
          return input.filter(':radio:checked').length > 0? input.filter(':radio:checked').val() : '';
        } else if (input.filter(':checkbox').length > 0) {
          return input.filter(':checkbox:checked').length > 0? input.filter(':checkbox:checked').val() : '';
        } else {
          return input.val();
        }
      }
      else {
        return argument;
      }
    },
    _setObjectVisibility: function(obj, visible) {
      if (visible) {
        obj.removeClass('hidden');
      }
      else {
        obj.addClass('hidden');
      }
    }
  };

  $(function() {
    $('form.hungryform').each(function() {
      new HungryForm(this);
    });
  });
}(jQuery));