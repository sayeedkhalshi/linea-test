// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Learn is ERC721 {
    using SafeMath for uint256;

    // string public constant name = "LEARN";
    // string public constant symbol = "LRN";

    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    mapping(address => mapping(address => uint256)) public allowed;

    constructor() ERC721("LEARN", "LRN") {
    totalSupply = 100000000;
    balances[msg.sender] = totalSupply;
    emit Transfer(address(0), msg.sender, totalSupply);
}

    function transfer(address _to, uint256 _value) public {
        require(balances[msg.sender] >= _value && _value > 0, "Not enough balance");
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
    }

    function approve(address _spender, uint256 _value) public override {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, true);
    }

    function transferFrom(address _from, address _to, uint256 _value) public override {
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0, "Not enough balance");
        balances[_from] = balances[_from].sub(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(_from, _to, _value);
    }

    function burn(uint256 _value) public {
        require(balances[msg.sender] >= _value && _value > 0, "Not enough balance");
        balances[msg.sender] = balances[msg.sender].sub(_value);
        totalSupply = totalSupply.sub(_value);
        emit Burn(msg.sender, _value);
    }

    // Accept funds
    function deposit() payable public {
        balances[msg.sender] = balances[msg.sender].add(msg.value);
    }

    // Withdraw funds
 function withdraw(uint256 _value) public {
    require(balances[msg.sender] >= _value && _value > 0, "Not enough balance");
    payable(msg.sender).transfer(_value);
    balances[msg.sender] = balances[msg.sender].sub(_value);
}
    //event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, bool _value);
    event Burn(address indexed _burner, uint256 _value);
}