using UnityEngine;
using static TagsAsStrings;

public class PlayerInput : MonoBehaviour {
    private PlayerMovement _movement;
    private ShieldControl _shieldControl;
    private WeaponController _weaponController;

    private void Awake(){
        _movement = GetComponent<PlayerMovement>();
        _weaponController = GameObject.FindGameObjectWithTag(weaponManagerTag).GetComponent<WeaponController>();
        _shieldControl = GetComponentInChildren<ShieldControl>();
    }

    private void Update(){
        _movement.upDownInput = Input.GetAxis("Vertical");
        _movement.sidewaysInput = Input.GetAxis("Horizontal");

        _shieldControl.shieldInput = Input.GetButtonDown("Shield");

        _movement.boostInput = Input.GetButton("Boost");

        _weaponController.fireInput = Input.GetButton("Fire1");

        _weaponController.nextWeaponInput = Input.GetButtonDown("Weapon Cycle");
    }
    
}