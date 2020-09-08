using System;
using UnityEngine;

public enum WeaponType {
    Plasma,
    Laser
}
public class WeaponController : MonoBehaviour {

    [NonSerialized] public bool fireInput;
    [NonSerialized] public bool secondFireInput;
    public WeaponType weaponType;
    private WeaponManager.IWeapon _iWeapon;

    private void HandleWeaponType(){
        Component c = gameObject.GetComponent<WeaponManager.IWeapon>() as Component;
        if (c != null) {
            Destroy(c);
        }

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

    private void Start(){
        HandleWeaponType();
    }

    private void Update(){
        if (fireInput) {
            Fire();
        }

        if (secondFireInput) {
            HandleWeaponType();
        }
    }
}