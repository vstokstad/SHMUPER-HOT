using System;
using UnityEngine;
using static WeaponType;


public enum WeaponType {
    Plasma = 0,
    Laser = 1,
    Missile = 2
}

public class WeaponController : MonoBehaviour {
    private WeaponManager.IWeapon _iWeapon;
    [NonSerialized] private WeaponType _weaponType;
    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool nextWeaponInput;


    private void Awake(){
        _weaponType = Plasma;
        HandleWeaponType(_weaponType);
    }

    private void Update(){
        if (fireInput) Fire();
        if (nextWeaponInput) {
            if (_weaponType == Missile) {
                _weaponType = Plasma;
                HandleWeaponType(_weaponType);
            }
            else {
                _weaponType += 1;
                HandleWeaponType(_weaponType);
            }
        }
    }


    private void HandleWeaponType(WeaponType weaponChoice){
        Component c = GetComponent<WeaponManager.IWeapon>() as Component;

        if (c != null) Destroy(c);

        switch (weaponChoice) {
            case Plasma:
                _iWeapon = gameObject.AddComponent<PlasmaShot>();
                break;
            case Laser:
                _iWeapon = gameObject.AddComponent<LaserBeam>();
                break;
            case Missile:
                _iWeapon = gameObject.AddComponent<HomingMissile>();
                break;

            default:
                _iWeapon = gameObject.AddComponent<PlasmaShot>();
                break;
        }
    }

    private void Fire(){
        _iWeapon.Shoot();
    }
}