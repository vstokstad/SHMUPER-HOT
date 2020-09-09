using System;
using UnityEngine;

public enum WeaponType {
    Plasma,
    Laser
}

public class WeaponController : MonoBehaviour {
    public WeaponType weaponType;
    private WeaponManager.IWeapon _iWeapon;

    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool secondFireInput;

    private void Start(){
        HandleWeaponType();
    }

    private void Update(){
        if (fireInput) Fire();

        if (secondFireInput) HandleWeaponType();
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
            default:
                _iWeapon = gameObject.AddComponent<WeaponManager.PlasmaShot>();
                break;
        }
    }

    public void Fire(){
        _iWeapon.Shoot();
    }

    public void SecondaryFire(){
        //TODO implement second type of weapon/ammo and use this.
        _iWeapon.Shoot();
    }
}