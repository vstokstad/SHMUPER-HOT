using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.iOS;
using UnityEngine.iOS;
using static TagsAsStrings;

public class Input : MonoBehaviour {
    private PlayerMovement _movement;
    private ShieldControl _shieldControl;
    private WeaponController _weaponController;
    private PlayerInput _playerInput;

    private void Awake(){
        _movement = GetComponent<PlayerMovement>();
        _weaponController = GameObject.FindGameObjectWithTag(weaponManagerTag).GetComponent<WeaponController>();
        _shieldControl = GetComponentInChildren<ShieldControl>();
#if ENABLE_INPUT_SYSTEM
        _playerInput = this.GetComponent<PlayerInput>();
        PlayerInput.ActionEvent fire = new PlayerInput.ActionEvent();


#endif
    }

    private void Update(){
#if ENABLE_LEGACY_INPUT_MANAGER
        _movement.upDownInput = Input.GetAxis("Vertical");
        _movement.sidewaysInput = Input.GetAxis("Horizontal");
        // _movement.upDownInput = UnityEngine.InputSystem.PlayerInputManager.instance.playerPrefab = gameObject;
        _shieldControl.shieldInput = Input.GetButtonDown("Shield");

        _movement.boostInput = Input.GetButton("Boost");

        _weaponController.fireInput = Input.GetButton("Fire1");

        _weaponController.nextWeaponInput = Input.GetButtonDown("Weapon Cycle");
#endif
    }
}