using UnityEngine;

[RequireComponent(typeof(PlayerMovement), typeof(PlayerActions))]
public class PlayerInput : MonoBehaviour {
    private PlayerActions _actions;
    private PlayerMovement _movement;
    private WeaponController _weaponController;


    private void Awake(){
        _movement = GetComponent<PlayerMovement>();
        _actions = GetComponent<PlayerActions>();
        _weaponController = GetComponent<WeaponController>();
    }

    private void Update(){
        _movement.upDownInput = Input.GetAxis("Vertical");
        _movement.sidewaysInput = Input.GetAxis("Horizontal");

        _movement.boostInput = Input.GetButton("Boost");

        _weaponController.fireInput = Input.GetButtonDown("Fire1");
        _weaponController.secondFireInput = Input.GetButtonDown("Fire2");
        _actions.shieldInput = Input.GetButtonDown("Shield");
        _actions.weaponCycle = Input.GetButtonDown("Weapon Cycle");
    }
}