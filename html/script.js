var moneyactuelle = 0;
var dirtymoneyactuelle = 0;
var bankbalanceactuelle = 0;

$(function(){

    window.addEventListener("message", function(event) {
		var mess = event.data;


		if(typeof mess.initialise !== 'undefined'){
			$('#money').html('💰' + mess.money + ' $');
			$('#dirtymoney').html('💵' + mess.dirtymoney + ' $');
			$('#bankbalance').html('💳' + mess.bankbalance + ' $');
			moneyactuelle = mess.money;
			dirtymoneyactuelle = mess.dirtymoneyinfo;
			bankbalanceactuelle = mess.bankbalanceinfo;
		}

		if(typeof mess.moneyinfo !== 'undefined'){
			$('#money').html('💰' + mess.moneyinfo + ' $');
			moneyactuelle = mess.moneyinfo;
		}

		if(typeof mess.dirtymoneyinfo !== 'undefined'){
			$('#dirtymoney').html('💵' + mess.dirtymoneyinfo + ' $');
			dirtymoneyactuelle = mess.dirtymoneyinfo;
		}

		if(typeof mess.bankbalanceinfo !== 'undefined'){
			$('#bankbalance').html('💳' + mess.bankbalanceinfo + ' $');
			bankbalanceactuelle = mess.bankbalanceinfo;
		}

		if(typeof mess.rmvBankForMoney !== 'undefined'){
			bankbalanceactuelle = Math.round(bankbalanceactuelle - mess.rmvBankForMoney);
			moneyactuelle = Math.round(moneyactuelle + mess.rmvBankForMoney);
			$('#bankbalance').html('💳' + bankbalanceactuelle + ' $');
			$('#money').html('💰' + moneyactuelle + ' $');
		}

		if(typeof mess.rmvMoneyForBank !== 'undefined'){
			bankbalanceactuelle = Math.round(bankbalanceactuelle + mess.rmvMoneyForBank);
			moneyactuelle = Math.round(moneyactuelle - mess.rmvMoneyForBank);
			$('#bankbalance').html('💳' + bankbalanceactuelle + ' $');
			$('#money').html('💰' + moneyactuelle + ' $');
		}

		if(typeof mess.addBank !== 'undefined'){
			bankbalanceactuelle = Math.round(bankbalanceactuelle + mess.addBank);
			$('#bankbalance').html('💳' + bankbalanceactuelle + ' $');
		}

		if(typeof mess.rmvBank !== 'undefined'){
			bankbalanceactuelle = Math.round(bankbalanceactuelle - mess.rmvBank);
			$('#bankbalance').html('💳' + bankbalanceactuelle + ' $');
		}

		if(typeof mess.addDirtyMoney !== 'undefined'){
			dirtymoneyactuelle = Math.round(dirtymoneyactuelle + mess.addDirtyMoney);
			$('#dirtymoney').html('💵' + dirtymoneyactuelle + ' $');
		}

		if(typeof mess.rmvDirtyMoney !== 'undefined'){
			dirtymoneyactuelle = Math.round(dirtymoneyactuelle - mess.rmvDirtyMoney);
			$('#dirtymoney').html('💵' + dirtymoneyactuelle + ' $');
		}

		if(typeof mess.addMoney !== 'undefined'){
			$('#addMoney').html('+' + mess.addMoney);
			var newMoney = Math.round(moneyactuelle + mess.addMoney);
			moneyactuelle = newMoney;
			$('#money').html('💰' + newMoney + ' $');
			$("#addMoney").fadeIn("slow", function(){
				setTimeout(function(){ 
					$("#addMoney").fadeOut( "slow", function() {
					});
				}, 2000);
  			});
		}

		if(typeof mess.rmvMoney !== 'undefined'){
			$('#rmvMoney').html('-' + mess.rmvMoney);
			var newMoney = Math.round(moneyactuelle - mess.rmvMoney);
			moneyactuelle = newMoney;
			$('#money').html('💰' + newMoney + ' $');
			$("#rmvMoney").fadeIn( "slow", function() {
				setTimeout(function(){
					$("#rmvMoney").fadeOut("slow", function() {
					});
				}, 2000);
  			});
		}
    });

});