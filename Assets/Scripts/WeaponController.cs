using System;
using UnityEngine;

public enum WeaponType {
    Plasma,
    Laser,
    HomingMissile
}

public class WeaponController : MonoBehaviour {
    public WeaponType weaponType;
    private WeaponManager.IWeapon _iWeapon;
    [NonSerialized] public bool cycleWeaponInput;

    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool secondFireInput;

    private void Start(){
        HandleWeaponType();
    }

    private void Update(){
        if (fireInput) Fire();
        if (secondFireInput) SecondaryFire();
        if (cycleWeaponInput) HandleWeaponType();
    }

    private void HandleWeaponType(){
        Component c = gameObject.GetComponent<WeaponManager.IWeapon>() as Component;
        if (c != null) Destroy(c);

        switch (weaponType) {
            case WeaponType.Plasma:
                _iWeapon = gameObject.AddComponent<WeaponManager.PlasmaShot>();
                break;
            case WeaponType.Laser:
                break;
            case WeaponType.HomingMissile:
                break;
            default:
                _iWeapon = gameObject.AddComponent<WeaponManager.PlasmaShot>();
                break;
        }
    }

    private void Fire(){
        _iWeapon.Shoot();
    }

    private void SecondaryFire(){
        //TODO implement second type of weapon/ammo and use this.
        _iWeapon.Shoot();
    }
}