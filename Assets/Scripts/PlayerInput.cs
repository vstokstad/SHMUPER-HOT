using UnityEngine;

[RequireComponent(typeof(PlayerMovement), typeof(PlayerController))]
public class PlayerInput : MonoBehaviour {
    private PlayerMovement _movement;
    private WeaponController _weaponController;


    private void Awake(){
        _movement = GetComponent<PlayerMovement>();
        _weaponController = GetComponent<WeaponController>();
    }

    private void Update(){
        _movement.upDownInput = Input.GetAxis("Vertical");
        _movement.sidewaysInput = Input.GetAxis("Horizontal");

        _movement.boostInput = Input.GetButton("Boost");

        _weaponController.fireInput = Input.GetButtonDown("Fire1");
        _weaponController.secondFireInput = Input.GetButtonDown("Fire2");
        _weaponController.cycleWeaponInput = Input.GetButtonDown("Weapon Cycle");
    }
}