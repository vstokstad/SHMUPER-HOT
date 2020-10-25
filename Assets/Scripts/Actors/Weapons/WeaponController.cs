using System;
using Actors.Player;
using Managers;
using UnityEngine;

namespace Actors.Weapons {
    [Serializable]
    public enum WeaponType {
        Plasma = 0,
        Laser = 1,
        Missile = 2
    }

    public class WeaponController : MonoBehaviour {
        [NonSerialized] public static WeaponType weaponType;
        public static bool laserEquipped;
        public bool plasmaEquipped;
        public static bool missileEquipped;
        private WeaponManager.IWeapon _iWeapon;

        //touchControls
    
        private void Awake(){
            plasmaEquipped = true;
            laserEquipped = false;
            missileEquipped = false;
            weaponType = WeaponType.Plasma;
            
        }

        private void Start(){
            HandleWeaponType(weaponType);
            PlayerInput.shoot += Fire;
            PlayerInput.nextWeapon += ChangeWeapon;
        }

        private void OnDisable(){
            // ReSharper disable once DelegateSubtraction
             PlayerInput.shoot -= Fire;
        }

        private void ChangeWeapon(){
            if (weaponType == WeaponType.Missile) {
                weaponType = WeaponType.Plasma;
                HandleWeaponType(weaponType);
            }
            else {
                weaponType += 1;
                HandleWeaponType(weaponType);
            }
        }

        public void HandleWeaponPickUp(){
            HandleWeaponType(weaponType);
        }

        private void HandleWeaponType(WeaponType weaponChoice){
            
            Component c = GetComponent<WeaponManager.IWeapon>() as Component;

            if (c != null) Destroy(c);

            switch (weaponChoice) {
                case WeaponType.Plasma:
                    if (!plasmaEquipped) goto case default;
                    _iWeapon = gameObject.AddComponent<PlasmaShot>();
                    break;
                case WeaponType.Laser:
                    if (!laserEquipped) goto case default;
                    _iWeapon = gameObject.AddComponent<LaserBeam>();
                    break;
                case WeaponType.Missile:
                    if (!missileEquipped) goto case default;
                    _iWeapon = gameObject.AddComponent<HomingMissile>();
                    break;

                default:
                    weaponType = WeaponType.Plasma;
                    plasmaEquipped = true;
                    _iWeapon = gameObject.AddComponent<PlasmaShot>();
                    break;
            }
        }

        private void Fire(){
            _iWeapon.Shoot();
        }
    }
}