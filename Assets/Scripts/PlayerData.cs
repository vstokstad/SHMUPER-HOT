using System;
using UnityEngine;

[CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptable/PlayerData", order = 0)]
public class PlayerData : ScriptableObject {
    [Header("Statistics")] public float health = 10f;
    public float rechargeTime = 10f;

    [Header("Move")] [Range(4f, 12f)] public float maxSpeed = 10f;
    public float crashDamage = 0.5f;
    public float acceleration = 3f;

    [Header("Weapons")] [Range(1, 10)] public int plasmaAmmunition = 5;

    public float laserAmmunition = 5f;
    public int homingMissileAmmunition = 5;
    private float _rechargeTimer;
    private GameObject _shieldBubble;
    [NonSerialized] public float boostForce = 1.2f;

    public bool ShieldIsActive {
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
            if (laserAmmunition < 5f) laserAmmunition += 1f * Time.deltaTime;
        }
        else if (_rechargeTimer <= 0f) {
            ShieldIsActive = true;

            if (boostForce <= 0f) boostForce = rechargeTime;
            _rechargeTimer = rechargeTime;
        }
    }
}