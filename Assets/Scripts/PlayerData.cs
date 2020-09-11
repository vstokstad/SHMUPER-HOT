using System;
using UnityEngine;

[CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptable/PlayerData", order = 0)]
public class PlayerData : ScriptableObject {
    [Header("Statistics")] public float health = 10f;
    public float rechargeTime = 5f;

    [Header("Move")] [Range(4f, 12f)] public float maxSpeed = 10f;
    public float crashDamage = 1f;
    public float acceleration = 3f;

    [Header("Weapons")] [Range(1, 10)] public int plasmaAmmunition = 5;

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
        }
        else if (_rechargeTimer <= 0f) {
            if (!_shieldBubble.activeSelf)
                _shieldBubble.SetActive(true);
            if (boostForce <= 2f) boostForce = _rechargeTimer;
            _rechargeTimer = rechargeTime;
        }
    }
}