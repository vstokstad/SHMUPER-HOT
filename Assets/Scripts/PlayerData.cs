using System;
using UnityEngine;

[CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptables/PlayerData", order = 0)]
public class PlayerData : ScriptableObject {
    [Header(header: "Statistics")] public float health = 3f;
    public float shieldCount = 1f;


    [Header(header: "Move")] 
    [Range(min: 1, max: 10)] public float turnSpeed = 10f;
    [Range(min: 4, max: 12)] public float moveSpeed = 10f;
    [Range(min: 1, max: 2)] public float boostForce = 5f;
    public bool boostChargeFull = true;

    [Header(header: "Weapons")]
    //public IWeapon[] weaponsOwned;
    // public IWeapon weaponSelected;
    public float ammunition = Single.PositiveInfinity;
}