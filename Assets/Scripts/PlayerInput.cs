using UnityEngine;

public class PlayerInput : MonoBehaviour {
    private static bool _gamePaused;
    private PlayerMovement _movement;
    private WeaponController _weaponController;

    private void Awake(){
        _movement = GetComponent<PlayerMovement>();
        _weaponController = GetComponent<WeaponController>();
    }

    private void Update(){
        _movement.upDownInput = Input.GetAxis("Vertical");
        _movement.sidewaysInput = Input.GetAxis("Horizontal");
        if (_gamePaused) return;
        _movement.boostInput = Input.GetButton("Boost");
        _weaponController.fireInput = Input.GetButtonDown("Fire1");
        _weaponController.secondFireInput = Input.GetButtonDown("Fire2");
        _weaponController.cycleWeaponInput = Input.GetButtonDown("Weapon Cycle");
    }

    public static void IsGamePaused(){
        _gamePaused = Time.timeScale == 0.0f;
    }

    public bool PlayerIsMoving(){
        return _movement.upDownInput != 0 || _movement.sidewaysInput != 0;
    }
}