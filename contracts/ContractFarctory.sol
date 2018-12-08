pragma solidity ^0.4.24;

import './NameRegistry.sol';

contract Asset {

    address public owner; // the owner of teh asset
    string public assetName; // type of asset
    string public desc; // description

    constructor (address _address, string _assetName, string _desc) public {
        owner = _address;
        assetName = _assetName;
        desc = _desc;
    }
}

contract AssetFactory {

    /*struct AssetList {
        address contractAddress;
    }*/
    //mapping(address => AssetList) assetLists;

    //address[] carAssets;
    address owner;
    NameRegistry nr; // create an object of name registry to call its function

    constructor (address _contractAddress) public {
        nr = NameRegistry(_contractAddress); // contract address of deployed NameRegistry
        owner = msg.sender;
    }

    modifier onlyOwner() { // access restriction
        require(msg.sender == owner, "No authorized.");
        _;
    }

    function createAsset(string _ownerName, address _owner, string _assetName, string _desc) public payable { // create a child contract - *payable, if you want to sell the asset
        address newAsset = new Asset(_owner, _assetName, _desc);
        /*AssetList memory asl = assetLists[_owner];
        asl = AssetList({
            contractAddress: newAsset
        });
        assetLists[_owner] = asl;*/
        //Assets.push(newAsset); // push new asset address to array
        nr.registerName(_ownerName, _owner, newAsset); // put data to another contract
    }

    function transferAsset(address _owner, string _newAssetOwner) public {
        nr.updateName(_owner, _newAssetOwner);
    }

    function getOwnerDetails(address _owner) public view returns (string, address) {
        // fetch owner's address and asset's address
        return nr.getContractDetails(_owner);
    }

    /*function getAllAssets() public view returns (address, string, string) { // check deployed child contract
        //Asset myAsset = Asset(Assets[0]);
        //return (myAsset.owner(), myAsset.assetName(), myAsset.desc());
        return assetLists[owner].contractAddress;
    }*/
}
