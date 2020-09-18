using System;
using UnityEngine;
using static WeaponType;


public enum WeaponType {
    Plasma = 0,
    Laser = 1,
    HomingMissile = 2
}

public class WeaponController : MonoBehaviour {
    private WeaponManager.IWeapon _iWeapon;
    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool nextWeaponInput;
    [NonSerialized] public WeaponType weaponType;


    private void Awake(){
        weaponType = Plasma;
        HandleWeaponType(weaponType);
    }

    private void Update(){
        if (fireInput) Fire();

        if (nextWeaponInput) {
            if (weaponType == WeaponType.HomingMissile) {
                weaponType = Plasma;
                HandleWeaponType(weaponType);
            }
            else {
                weaponType += 1;
                HandleWeaponType(weaponType);
            }
        }
    }


    private void HandleWeaponType(WeaponType weaponChoice){
        Component c = gameObject.GetComponent<WeaponManager.IWeapon>() as Component;

        if (c != null) Destroy(c);

        switch (weaponChoice) {
            case Plasma:
                _iWeapon = gameObject.AddComponent<PlasmaShot>();
                break;
            case Laser:
                _iWeapon = gameObject.AddComponent<LaserBeam>();
                break;
            case WeaponType.HomingMissile:
                _iWeapon = gameObject.AddComponent<HomingMissile>();
                break;
            default:
                weaponType = Plasma;
                _iWeapon = gameObject.AddComponent<PlasmaShot>();
                break;
        }
    }

    private void Fire(){
        _iWeapon.Shoot();
    }
}