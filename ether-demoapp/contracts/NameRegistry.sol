pragma solidity ^0.4.24;

contract NameRegistry {
    struct ContractDetails {
        string ownerName;
        address contractAddress;
    }

    mapping(address => ContractDetails) registry;

    function registerName(string _assetOwner, address _owner, address _contractAddress) external returns (bool) {
        ContractDetails memory info = registry[_owner];
        info = ContractDetails ({
            ownerName: _assetOwner,
            contractAddress: _contractAddress
        });
        registry[_owner] = info;
        return true;
    }

    function updateName(address _oldOwner, string _newAssetOwner) external returns (bool) {
        ContractDetails memory info = registry[_oldOwner];
        info.ownerName = _newAssetOwner;
        registry[_oldOwner] = info;
        return true;
    }

    function getContractDetails(address _owner) external view returns (string, address) {
        return (registry[_owner].ownerName, registry[_owner].contractAddress);
    }
}
