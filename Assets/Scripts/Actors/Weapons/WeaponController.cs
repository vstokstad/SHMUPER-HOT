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
        [SerializeField] public bool debugMode;
        [NonSerialized] public static WeaponType weaponType;
        public static bool laserEquipped;
        // ReSharper disable once MemberCanBePrivate.Global
        public static bool plasmaEquipped;
        public static bool missileEquipped;
        private WeaponManager.IWeapon _iWeapon;
        [NonSerialized] public bool fireInput;
    
        [NonSerialized] public bool nextWeaponInput;

        //touchControls
    
        private void Awake(){
            plasmaEquipped = true;
            laserEquipped = false;
            missileEquipped = false;
            weaponType = WeaponType.Plasma;
            HandleWeaponType(weaponType);
        }

        private void OnEnable(){
            PlayerInput.shoot += Fire;
        }

        private void OnDisable(){
            PlayerInput.shoot -= Fire;
        }

        private void Update(){
            if (fireInput) Fire();
            if (!nextWeaponInput) return;
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

        public void HandleWeaponType(WeaponType weaponChoice){

            if (debugMode) {
                plasmaEquipped = true;
                laserEquipped = true;
                missileEquipped = true;
            }
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
                    _iWeapon = gameObject.AddComponent<PlasmaShot>();
                    break;
            }
        }

        private void Fire(){
            _iWeapon.Shoot();
        }
    }
}