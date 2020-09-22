using System;
using UnityEngine;
using static WeaponType;

[Serializable]
public enum WeaponType {
    Plasma = 0,
    Laser = 1,
    Missile = 2
}

public class WeaponController : MonoBehaviour {
    [NonSerialized] public static WeaponType weaponType;
    [NonSerialized] public static bool laserEquipped;
    [NonSerialized] public static bool plasmaEquipped;
    [NonSerialized] public static bool missileEquipped;
    private WeaponManager.IWeapon _iWeapon;
    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool nextWeaponInput;

    private void Awake(){
        plasmaEquipped = true;
        laserEquipped = false;
        missileEquipped = false;
        weaponType = Plasma;
        HandleWeaponType(weaponType);
    }

    private void Update(){
        if (fireInput) Fire();
        if (nextWeaponInput) {
            if (weaponType == Missile) {
                weaponType = Plasma;
                HandleWeaponType(weaponType);
            }
            else {
                weaponType += 1;
                HandleWeaponType(weaponType);
            }
        }
    }

    public void HandleWeaponPickUp(){
        HandleWeaponType(weaponType);
    }

    public void HandleWeaponType(WeaponType weaponChoice){
        Component c = GetComponent<WeaponManager.IWeapon>() as Component;

        if (c != null) Destroy(c);

        switch (weaponChoice) {
            case Plasma:
                if (!plasmaEquipped) goto case default;
                _iWeapon = gameObject.AddComponent<PlasmaShot>();
                break;
            case Laser:
                if (!laserEquipped) goto case default;
                _iWeapon = gameObject.AddComponent<LaserBeam>();
                break;
            case Missile:
                if (!missileEquipped) goto case default;
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