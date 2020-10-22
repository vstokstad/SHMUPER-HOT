using UnityEngine;

namespace Managers {
    public abstract class WeaponManager : MonoBehaviour {
        public interface IWeapon {
            void Shoot();
        }
    }
}