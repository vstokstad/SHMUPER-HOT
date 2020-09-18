using UnityEngine;

public abstract class WeaponManager : MonoBehaviour {
    public interface IWeapon {
        void Shoot();
    }
}