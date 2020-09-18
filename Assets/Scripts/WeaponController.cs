using System;
using UnityEngine;
using static WeaponType;


public enum WeaponType {
    Plasma = 0,
    Laser = 1,
    HomingMissile = 2
}

public class WeaponController : MonoBehaviour {
    [NonSerialized] public WeaponType weaponType;
    private WeaponManager.IWeapon _iWeapon;
    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool nextWeaponInput;
    [NonSerialized] public bool weapon1;
    [NonSerialized] public bool weapon2;
    [NonSerialized] public bool weapon3;

    private void Awake(){
        weaponType = Plasma;
    }

    private void Start(){
        HandleWeaponType(weaponType);
    }

    private void Update(){
        if (fireInput) Fire();
        /*if (weapon1) {
            weaponType = Plasma;
            HandleWeaponType(weaponType);
        }

        if (weapon2) {
            weaponType = Laser;
            HandleWeaponType(weaponType);
        }

        if (weapon3) {
            weaponType = HomingMissile;
            HandleWeaponType(weaponType);
        }*/

        if (nextWeaponInput) {
            if (weaponType == HomingMissile) {
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
        
        if(c!=null){
            Destroy(c);
        }
        
        switch (weaponChoice) {
            case Plasma:
                _iWeapon = gameObject.AddComponent<WeaponManager.PlasmaShot>();
                break;
            case Laser:
                _iWeapon = gameObject.AddComponent<WeaponManager.LaserBeam>();
                break;
            case HomingMissile:
                break;
            default:
                weaponType = Plasma;
                _iWeapon = gameObject.AddComponent<WeaponManager.PlasmaShot>();
                break;
        }
    }

    private void Fire(){
        _iWeapon.Shoot();
    }
}