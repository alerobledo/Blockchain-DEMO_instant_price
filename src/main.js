const Web3 = require("web3");
// https://bsc-dataseed1.binance.org:443  (mainnet?)
const web3 = new Web3("https://data-seed-prebsc-1-s1.binance.org:8545");

const aggregatorV3InterfaceABI = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "getLatestPriceFeed",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "pair",
						"type": "string"
					},
					{
						"internalType": "int256",
						"name": "priceFeed",
						"type": "int256"
					},
					{
						"internalType": "uint8",
						"name": "decimals",
						"type": "uint8"
					}
				],
				"internalType": "struct PriceConsumerV3.PairInfo[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];

const addr = "0x72f1A0B1F7EFfc1b8b10E0Aee3749e06333b67B7"; // multi aggregator
const updateInterval = 5000; //5 seconds   30000; //30 seconds
const priceFeed = new web3.eth.Contract(aggregatorV3InterfaceABI, addr);

window.addEventListener("load", () => {
    setInterval(function() {        
        priceFeed.methods.getLatestPriceFeed().call()
        .then((roundData) => {
            var htmlContent = "";
            roundData.forEach(element => {
                console.log("pair:", element.pair + "  - price: "+element.priceFeed+"  - decimals: "+element.decimals);
                
                var price = element.priceFeed / 10**element.decimals;
                htmlContent += "<br/>" + element.pair + " - "+price;
            });
            document.querySelector("#cryptoMarket").innerHTML = htmlContent
        });    
    }, updateInterval);
  })