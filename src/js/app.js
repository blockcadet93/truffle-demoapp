App = {
  initWeb3: async () => {
    if (window.ethereum) {
      App.web3Provider = window.ethereum;
      try {
        await window.ethereum.enable();
      } catch(error) {
        consol.error("user denied account access");
      }
    }
    else if (window.web3) {
      App.web3Provider = window.web3.currentProvider;
    }
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
    }
    web3 = new Web3(App.web3Provider);

    return App.bindEvents;
  },

  bindEvents: () => {
    $(document).on('click', 'btn-get', App.getContractDetails);
    $(document).on('click', 'btn-create', App.createAsset);
  },

  getContractDetails: () => {
    console.log("Contract details");
    $.getJSON('../AssetFactory.json', (data) => {
      App.AssetFactory = TruffleContract(data);
      App.setProvider(App.web3Provider);

      App.AssetFactory.deployed().then((instance) => {
        return console.log(instance);
      });
    });
    return App.bindEvents;
  },

  createAsset: () => {
    console.log("Create asset");
    return App.bindEvents;
  }
};

$(function() {
  $(window).load(function() {
    App.initWeb3();
  });
});
