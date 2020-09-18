using System;
using UnityEngine;

[CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptable/PlayerData", order = 0)]
public class PlayerData : ScriptableObject {
    [Header("Statistics")] public float health = 10f;

    public float rechargeTime = 5f;

    [Header("Move")] [Range(4f, 12f)] public float maxSpeed = 10f;

    public float crashDamage = 0.5f;
    public float acceleration = 3f;

    [Header("Weapons")] public float laserAmmunition = 5f;


    private float _rechargeTimer;
    private GameObject _shieldBubble;
    [NonSerialized] public float boostCharge = 10f;

    public bool ShieldIsLoaded {
        get => _shieldBubble.activeSelf;
        set => _shieldBubble.SetActive(value);
    }

    private void OnEnable(){
        _shieldBubble = GameObject.Find("Shield");
    }


//Charges shield and booster
    public void RechargeTimer(){
        if (_rechargeTimer > 0f) {
            _rechargeTimer -= Time.deltaTime;
        }
        else if (_rechargeTimer <= 0f) {
            laserAmmunition = 5;
            ShieldIsLoaded = true;
            if (boostCharge < 0.1f && boostCharge < 10f) boostCharge += rechargeTime * Time.deltaTime;
            _rechargeTimer = rechargeTime;
        }
    }
}