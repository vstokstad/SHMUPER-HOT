using System;
using System.Collections.Generic;
using UnityEngine;

public class WeaponController : MonoBehaviour {
    public WeaponType weaponType;
    private WeaponManager.IWeapon _iWeapon;
    private IEnumerator<WeaponType> _weaponSwitch;
    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool nextWeaponInput;

    private void Start(){
        HandleWeaponType();
    }

    private void Update(){
        if (fireInput) Fire();
        if (nextWeaponInput) { }
    }


    private void HandleWeaponType(){
        switch (weaponType) {
            case WeaponType.Plasma:
                _iWeapon = gameObject.AddComponent<WeaponManager.PlasmaShot>();
                break;
            case WeaponType.Laser:
                break;
            case WeaponType.HomingMissile:
                break;
            default:
                weaponType = WeaponType.Plasma;
                _iWeapon = gameObject.AddComponent<WeaponManager.PlasmaShot>();
                break;
        }
    }

    private void Fire(){
        _iWeapon.Shoot();
    }
}